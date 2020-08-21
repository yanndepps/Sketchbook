// generateme.tumblr.com
// using OpenGL shader example
// imagelens

// shader declaration
PShader sh;

String uid;

void setup() {
  uid = hex((int)random(0x10000),4);
  PImage img = loadImage("w.jpg");
  
  size(600, 600,P2D);
  background(0);
  
  // load and compile shader
  sh = loadShader("lens.glsl");
  // upload texture to graphics card
  sh.set("texture",img);
}

void draw() {
  // normalize mouse position
  float inpx = mouseX/(float)width;
  float inpy = mouseY/(float)height;
  
  // set shader variable
  sh.set("inp",inpx,inpy);
  
  // run shader
  shader(sh);
  
  // fill whole window
  rect(0,0,width,height);
}

void keyPressed() {
  saveFrame("res"+uid+"######.jpg");
}