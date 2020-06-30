PShape[] shapes;
Mesh base;

void setup() {
  fullScreen(P3D);
  smooth(16);
  createBase();
  shapes=new PShape[6];
  for (int r=0; r<6; r++) {
    shapes[r]=createShapes(250+100*r);
  }
}

void createBase() {
  int[] faces=new int[3*245760];
  BufferedReader reader = createReader("faces.txt");
  String line;
  int index=0;
  try {
    for (int i=0; i<245760; i++) {
      line = reader.readLine();
      String[] pieces = split(line, ',');
      faces[index++] = int(pieces[0]);
      faces[index++] = int(pieces[1]);
      faces[index++] = int(pieces[2]);
    }
    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
  
  float[][] vertices=new float[122882][3];
  reader = createReader("vertices.txt");
  try {
    for (int i=0; i<122882; i++) {
      line = reader.readLine();
      String[] pieces = split(line, ',');
      vertices[i][0] = float(pieces[0]);
      vertices[i][1] = float(pieces[1]);
      vertices[i][2] = float(pieces[2]);
    }
    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
  base = new Mesh(faces,vertices,1.0);
}

PShape createShapes(float radius) {
  Mesh mesh= base.copy(radius);
  float scale=(200.0/radius);
  float d,f;
  for(float[] v: mesh.vertices) {
    f=f(v[0], v[1], v[2]);
    d=1.0+scale*f*f;
    v[0]*=d;
    v[1]*=d;
    v[2]*=d;
  }
  PShape shape=mesh.getShape();
  shape.disableStyle();
  return shape;
}

void draw() {
  background(250,250,240);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(200, 200, 200, -1, -1, 1);
  translate(width/2, height/2); 
  rotateY(map(mouseX, 0, width, -PI, PI));
  rotateX(map(mouseY, 0, height, -PI, PI));
  fill(255);
  strokeWeight(0.4);
  stroke(0);
  shape(shapes[0], 0, 0);
  noFill();
  for (int r=1; r<6; r++) {
    shape(shapes[r], 0, 0);
  }
}

//https://thebookofshaders.com/13/
float fbm(float x, float y, float z) {
  // Properties
  int octaves = 4;
  float lacunarity = 2.0;
  float gain = 0.5;
  //
  // Initial values
  float value=0.0;
  float amplitude = 0.8;
  float frequency = 0.01;
  //
  // Loop of octaves
  float sa=sin(0.5);
  float ca=cos(0.5);
  float ox;
  for (int i = 0; i < octaves; i++) {
    ox=x;
    x=x*sa+y*ca;
    y=-ox*ca+y*sa;
    value += amplitude * (-1.0+2.0*noise(frequency*x, frequency*y, frequency*z));
    frequency *= lacunarity;
    amplitude *= gain;
  }
  return value;
}

float f(float x, float y, float z) {
  float tmp=fbm(x, y, z);
  tmp=fbm(x+32*tmp, y+32*tmp, z+32*tmp);
  tmp=fbm(x+64*tmp, y+64*tmp, z+64*tmp);
  return tmp;
}
