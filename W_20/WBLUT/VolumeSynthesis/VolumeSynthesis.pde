//number of cells per dimension
int sideX, sideY, sideZ;
//number of points per dimension (=number of cells plus one)
int sideXpo, sideYpo, sideZpo; 
//halved number of points per dimension
int halfSideXpo, halfSideYpo, halfSideZpo; 
//cell size per dimension
float scaleX, scaleY, scaleZ; 

//3D array of float values, holds the accumulated value in each cell
float[][][] floatGrid; 
//2D array of float values, holds the accumulated value in each vertical column
float[][] transmissionDown; 

//number of volumes to add and subtract
int numberOfVolumes;
// 6 values per voulme: lower left back corner and upper right front corner
int[][] volumes; 

//value above which teh cell becomes visible
float visibilityTreshold;  
//value to add per volume
float visibilityFactor; 

//binary grid for rendering, true=cell is visible
BinaryGrid3D binaryGrid;

//view angles
float angleY; 
float angleX; 

void setup() {
  fullScreen(P3D);
  smooth(8);
  noCursor();
  frameRate(30);
  initializeParameters();
  initializeVolumes();
}

void initializeParameters() {
  sideX=40; 
  sideY=40;
  sideZ=40;
  sideXpo=sideX+1; 
  sideYpo=sideY+1; 
  sideZpo=sideZ+1; 
  halfSideXpo=int(sideXpo/2.0f); 
  halfSideYpo=int(sideYpo/2.0f); 
  halfSideZpo=int(sideZpo/2.0f); 
  scaleX=600.0/sideXpo;
  scaleY=600.0/sideYpo; 
  scaleZ=600.0/sideZpo; 

  floatGrid=new float[sideXpo][sideYpo][sideZpo]; 

  transmissionDown=new float[sideXpo][sideZpo]; 

  numberOfVolumes=52; 
  volumes=new int[numberOfVolumes][6]; 
  visibilityTreshold=0.5;  
  visibilityFactor=1.0; 

  angleY=0.50; 
  angleX=-0.5;
}

void initializeVolumes() {
  for (int vol=0; vol<numberOfVolumes; vol++) {
    volumes[vol][0]=int(random(sideX));
    volumes[vol][3]= volumes[vol][0]+int(random(sideX-volumes[vol][0]+1));
    volumes[vol][1]=int(random(sideY));
    volumes[vol][4]= volumes[vol][1]+int(random(sideY-volumes[vol][1]+1));
    volumes[vol][2]=int(random(sideZ));
    volumes[vol][5]= volumes[vol][2]+int(random(sideZ-volumes[vol][2]+1));
  }
  binaryGrid=BinaryGrid3D.createGrid(new PVector(), sideXpo, scaleX, sideYpo, scaleY, sideZpo, scaleZ);
}

void draw() {
  background(25);
  lights();
  //Gradually incorporate more volumes in initial buildup
  if (frameCount<5*numberOfVolumes+1) {
    rebuildGrid(min(frameCount/5, numberOfVolumes));
  }
  translate(width/2, height/2,-250);
  rotateX(angleX);
  rotateY(angleY=map(mouseX, 0, width, -PI, PI));
  drawTransmissionDown();
  drawGroundPlane();
  translate(0,-150,0);
  drawYLevel((int)(0.5*frameCount)%(sideYpo-1));
  drawYLevel((int)(0.6*frameCount+7)%(sideYpo-1));
  drawZLevel((int)(0.4*frameCount)%(sideZpo-1));
  drawXLevel((int)(0.4*frameCount+13)%(sideXpo-1));
  drawOutline();

}

void drawXLevel(int x) {
  noStroke();
  fill(255);
  binaryGrid.setLimits(x, x+1, 0, sideYpo, 0, sideZpo);
  drawBinaryGrid3D(binaryGrid);
}

void drawYLevel(int y) {
  noStroke();
  fill(255);
  binaryGrid.setLimits(0, sideXpo, y, y+1, 0, sideZpo);
  drawBinaryGrid3D(binaryGrid);
}

void drawZLevel(int z) {
  noStroke();
  fill(255);
  binaryGrid.setLimits(0, sideXpo, 0, sideYpo, z, z+1);
  drawBinaryGrid3D(binaryGrid);
}

void drawOutline(){
  noFill();
  stroke(125);
  binaryGrid.clearLimits();
  drawBinaryGridOutline3D(binaryGrid);
}

//alternatively add and subtract a volume from the grid
void rebuildGrid(int numberOfVolumes) {
  visibilityFactor=1.0;//start with adding a volume
  resetGrid();
  for (int vol=0; vol<numberOfVolumes; vol++) { 
    for (int i=volumes[vol][0]; i<volumes[vol][3]; i++) {
      for (int j=volumes[vol][1]; j<volumes[vol][4]; j++) {
        for (int k=volumes[vol][2]; k<volumes[vol][5]; k++) {
          floatGrid[i][j][k]+=visibilityFactor;
        }
      }
    }
    switchPolarity();
  } 
  setBinaryGrid(visibilityTreshold);
  setTransmission(visibilityTreshold);
}

void switchPolarity() {
  //Add 1.0, buts subtract 0.9 for more residual traces
  visibilityFactor*=-1.0;
  if (visibilityFactor<0.0) {
    visibilityFactor=-0.9;
  } else {
    visibilityFactor=1.0;
  }
}

void resetGrid() {
  for (int i=0; i<sideXpo; i++) {
    for (int k=0; k<sideZpo; k++) {
      transmissionDown[i][k]=0.0f;
      for (int j=0; j<sideYpo; j++) {
        floatGrid[i][j][k]=0.0f;
      }
    }
  }
}

void setBinaryGrid(float visibilityTreshold) {
  for (int i=0; i<sideXpo; i++) {
    for (int j=0; j<sideYpo; j++) {
      for (int k=0; k<sideZpo; k++) {
        binaryGrid.clear(i, j, k);
        if (floatGrid[i][j][k]>=visibilityTreshold) binaryGrid.set(i, j, k);
      }
    }
  }
}

void setTransmission(float visibilityTreshold) {
  for (int i=0; i<sideXpo; i++) {
    for (int j=0; j<sideYpo; j++) {
      for (int k=0; k<sideZpo; k++) {
         if (floatGrid[i][j][k]>visibilityTreshold) transmissionDown[i][k]+=floatGrid[i][j][k] ;
      }
    }
  }
}

void drawGroundPlane() {
  fill(55);
  stroke(125);
  beginShape(QUADS);
  vertex(-1.2*scaleX*halfSideXpo, scaleY*(sideY-halfSideYpo)+10, -1.2*scaleZ*halfSideZpo);
  vertex(1.2*scaleX*halfSideXpo, scaleY*(sideY-halfSideYpo)+10, -1.2*scaleZ*halfSideZpo);
  vertex(1.2*scaleX*halfSideXpo, scaleY*(sideY-halfSideYpo)+10, 1.2*scaleZ*halfSideZpo);
  vertex(-1.2*scaleX*halfSideXpo, scaleY*(sideY-halfSideYpo)+10, 1.2*scaleZ*halfSideZpo);
  endShape();
}

void drawTransmissionDown() {
  noStroke();
  beginShape(QUADS);
  for (int k=0; k<sideZpo; k++) {
    for (int i=0; i<sideXpo; i++) {
      fill(255, 255-int(transmissionDown[i][k]*8));
      vertexIK(i+0.5, k+0.5);
      vertexIK(i-0.5, k+0.5);
      vertexIK(i-0.5, k-0.5);
      vertexIK(i+0.5, k-0.5);
    }
  }
  endShape();
}

void vertexIK(float i, float k) {
  vertex(scaleX*(i-halfSideXpo), scaleY*(sideY-halfSideYpo)+9.9, scaleZ*(k-halfSideZpo));
}

void mousePressed() {
  initializeVolumes();
  frameCount=0;
}
