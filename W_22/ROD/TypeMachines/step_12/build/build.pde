/*
 * TypeMachines -> step_12
 * example -> 3D typography
 * */

PFont thing;
String txt = "The oldest known human presence in Athens is the Cave of Schist, which has been dated to between the 11th and 7th millennia BC ... ";
float fs; // font size
float lh; // line height
float fov = PI/3.0;
color fg = #f4f4f4;
color bg = #333333;

void setup() {
  size(620, 620, P3D);
  imageMode(CENTER);
  // ---
  thing = createFont("thing.otf", 1000, true);
  fs = ceil( width * 2.0 );
  lh = ceil( width * 0.0016 );
  println("font size -> ", fs);
  println("line height -> ", lh);
}

void draw() {
  background(bg);
  perspective(fov, (float)width/(float)height, 1, 100000);
  fill(fg);
  // ---
  float range = 2400;
  float eyeX = width/2.0 + map(mouseX, 0, width, -range, range);
  float eyeY = height/2.0 + map(mouseY, 0, height, -range, range);
  float eyeZ = (height/2.0) / tan(PI*30.0/100.0) + 400;
  float centerX = width/2.0;
  float centerY = height/2.0;
  float centerZ = 0;
  float upX = 0;
  float upY = 1;
  float upZ = 0;
  // ---
  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  // ---
  push();
  textFont(thing);
  textSize(fs);
  textAlign(LEFT, CENTER);
  float w = textWidth(txt);
  String txtUp = txt.toUpperCase();
  translate(-frameCount*100, 500, 0);
  float wave = map(sin(radians(frameCount)), -1, 1, -7, 7);
  text(txtUp, 0, 0);
  pop();
  // ---
}
