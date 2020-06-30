PGraphics offscreen;
Square[][][] grid;
float[][][] values;
int resx;
float halfresx;
int resy;
float halfresy;
float scalex, scaley, scalez;
float noiseScale;
float noiseChange;
int inc;
PShader blur, filter;
void setup() {
  fullScreen(P3D);
  smooth(16);
  noCursor();

  offscreen=createGraphics(width, height, P3D);
  offscreen.beginDraw();
  offscreen.smooth(16);
  offscreen.background(0);
  offscreen.noFill();
  offscreen.colorMode(HSB);
  offscreen.endDraw();
  noiseDetail(8, 0.5f);
  createGrid();
  blur=loadShader("blur.glsl");
  filter = loadShader("chromatic1.glsl");
  filter.set("resolution", width, height);
  filter.set("levels", 4);
  filter.set("lens", -.07f);
  filter.set("lowcolor", 1.0f, 0.0f, 0.0f);
  filter.set("midcolor", 0.0f, 1.0f, 0.0f);
  filter.set("highcolor", 0.0f, 0.0f, 1.0f);
}

void createGrid() {

  inc=160;
  resx=100;
  halfresx=50.5;
  resy=100;
  halfresy=50.5;
  scalex=8.0;
  scaley=8.0; 

  grid = new Square[resx][resy][2*inc+1];
  values = new float[resx+1][resy+1][2*inc+1];
  noiseScale=80.0f;
  noiseChange=200.0f;
  for (int i=0; i<resx+1; i++) {
    for (int j=0; j<resy+1; j++) {
      for (int k=0; k<2*inc+1; k++) {
        values[i][j][k]=noise(i/noiseScale, j/noiseScale, k/noiseChange);
      }
    }
  }
  for (int i=0; i<resx; i++) {
    for (int j=0; j<resy; j++) {
      for (int k=0; k<2*inc+1; k++) {
        grid[i][j][k]=new Square(values[i][j][k], values[i+1][j][k], values[i+1][j+1][k], values[i][j+1][k]);
      }
    }
  }
}


void draw() {
  background(0);
  blendMode(ADD);
  for (int r=0; r<8; r++) {

    drawOffscreen(r*(inc/8), (r+1)*(inc/8));
    tint(255, 100+20*r);
    image(offscreen, 0, 0, width, height, 0, 0, width, height);
    blur();
    filter(filter);
  }
  drawOffscreen(inc, (int)(1.2*inc));

  tint(255);
  image(offscreen, 0, 0, width, height, 0, 0, width, height);
  filter(filter);
}

void drawOffscreen(int start, int end) {
  offscreen.beginDraw();
  offscreen.ortho();
  offscreen.translate(width/2, height/2, -100);
  offscreen.background(0);


  for (int i=0; i<resx; i++) {
    for (int j=0; j<resy; j++) {
      for (int k=start; k<end; k++) {
        offscreen.stroke(255, 50+0.5*k);
        grid[i][j][k].draw((i-halfresx)*scalex, (j-halfresy)*scaley, scalex, scaley, 0.3+0.4*mouseY/(float)height, k-inc, offscreen);
      }
    }
  }
  offscreen.endDraw();
}

void blur() {
  blur.set("blurSize", 5);
  blur.set("sigma", 2.5); 
  blur.set("horizontalPass", 0);
  filter(blur);
  blur.set("horizontalPass", 1);
  filter(blur);
}



class Square {
  float[] v = new float[4];

  Square() {
    for (int i=0; i<4; i++) {
      v[i]=0.0f;
    }
  }

  Square(float v0, float v1, float v2, float v3) {
    v[0]=v0;
    v[1]=v1;
    v[2]=v2;
    v[3]=v3;
  }

  int determineType(float threshold) {
    int lv0, lv1, lv2, lv3;
    lv0=lv1=lv2=lv3=0;
    if (v[0]<=threshold) lv0=1;
    if (v[1]<=threshold) lv1=2;  
    if (v[2]<=threshold) lv2=4;
    if (v[3]<=threshold) lv3=8;
    return lv0+lv1+lv2+lv3;
  };

  void update(float v0, float v1, float v2, float v3) {
    v[0]=v0;
    v[1]=v1;
    v[2]=v2;
    v[3]=v3;
  }
  void draw(float offsetx, float offsety, float scalex, float scaley, float threshold, float z, PGraphics offscreen) {
    int type = determineType(threshold);
    offscreen.beginShape(LINES);
    switch (type) {
    case 0:
      break;
    case 1:

      offscreen.vertex(offsetx, offsety+interpolate(v[0], v[3], threshold)*scaley, z);
      offscreen.vertex(offsetx+interpolate(v[0], v[1], threshold)*scalex, offsety, z);
      break;
    case 2:

      offscreen.vertex(offsetx+scalex, offsety+interpolate(v[1], v[2], threshold)*scaley, z);
      offscreen.vertex(offsetx+interpolate(v[0], v[1], threshold)*scaley, offsety, z);
      break;
    case 3:

      offscreen.vertex(offsetx, offsety+interpolate(v[0], v[3], threshold)*scaley, z);
      offscreen.vertex(offsetx+scalex, offsety+interpolate(v[1], v[2], threshold)*scaley, z);

      break;
    case 4:

      offscreen.vertex(offsetx+scalex, offsety+interpolate(v[1], v[2], threshold)*scaley, z);
      offscreen.vertex(offsetx+interpolate(v[3], v[2], threshold)*scalex, offsety+scaley, z);
      break;
    case 5:

      offscreen.vertex(offsetx, offsety+interpolate(v[0], v[3], threshold)*scaley, z);
      offscreen.vertex(offsetx+interpolate(v[0], v[1], threshold)*scaley, offsety, z);

      offscreen.vertex(offsetx+scalex, offsety+interpolate(v[1], v[2], threshold)*scaley, z);
      offscreen.vertex(offsetx+interpolate(v[3], v[2], threshold)*scalex, offsety+scaley, z);
      break;
    case 6:

      offscreen.vertex(offsetx+interpolate(v[0], v[1], threshold)*scalex, offsety, z);
      offscreen.vertex(offsetx+interpolate(v[3], v[2], threshold)*scalex, offsety+scaley, z);

      break;
    case 7:

      offscreen.vertex(offsetx, offsety+interpolate(v[0], v[3], threshold)*scaley, z);
      offscreen.vertex(offsetx+interpolate(v[3], v[2], threshold)*scalex, offsety+scaley, z);

      break;
    case 8:
      offscreen.vertex(offsetx, offsety+interpolate(v[0], v[3], threshold)*scaley, z);
      offscreen.vertex(offsetx+interpolate(v[3], v[2], threshold)*scalex, offsety+scaley, z);
      break;
    case 9:
      offscreen.vertex(offsetx+interpolate(v[0], v[1], threshold)*scalex, offsety, z);
      offscreen.vertex(offsetx+interpolate(v[3], v[2], threshold)*scalex, offsety+scaley, z);
      break;
    case 10:
      offscreen.vertex(offsetx+scalex, offsety+interpolate(v[1], v[2], threshold)*scaley, z);
      offscreen.vertex(offsetx+interpolate(v[0], v[1], threshold)*scalex, offsety, z);
      offscreen.vertex(offsetx, offsety+interpolate(v[0], v[3], threshold)*scaley, z);
      offscreen.vertex(offsetx+interpolate(v[3], v[2], threshold)*scalex, offsety+scaley, z);
      break;
    case 11:
      offscreen.vertex(offsetx+scalex, offsety+interpolate(v[1], v[2], threshold)*scaley, z);
      offscreen.vertex(offsetx+interpolate(v[3], v[2], threshold)*scalex, offsety+scaley, z);
      break;
    case 12:
      offscreen.vertex(offsetx, offsety+interpolate(v[0], v[3], threshold)*scaley, z);
      offscreen.vertex(offsetx+scalex, offsety+interpolate(v[1], v[2], threshold)*scaley, z);
      break;
    case 13:
      offscreen.vertex(offsetx+scalex, offsety+interpolate(v[1], v[2], threshold)*scaley, z);
      offscreen.vertex(offsetx+interpolate(v[0], v[1], threshold)*scalex, offsety, z);
      break;
    case 14:
      offscreen.vertex(offsetx, offsety+interpolate(v[0], v[3], threshold)*scaley, z);
      offscreen.vertex(offsetx+interpolate(v[0], v[1], threshold)*scalex, offsety, z);
      break;
    case 15:
      break;
    default:
      break;
    }
    offscreen.endShape();
  }

  float interpolate(float xi, float xj, float threshold) {
    return( (threshold-xi)/(xj-xi));
  }
}
