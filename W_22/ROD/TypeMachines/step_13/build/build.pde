/*
 * TypeMachines -> step_13
 * example -> circular distribution
 * */

PFont thing;
String txt = "TYPEMACHINES";
float fs; // font size
float lh; // line height
color fg = #f4f4f4;
color bg = #333333;

void setup() {
  size(620, 620);
  // ---
  thing = createFont("thing.otf", 800, true);
  textFont(thing);
  textAlign(LEFT, CENTER);
  // ---
  fs = ceil( width * 0.16 );
  lh = ceil( width * 0.0016 );
  // ---
  println("font size -> ", fs);
  // println("line height -> ", lh);
}

void draw() {
  background(bg);
  fill(fg);
  // ---
  textSize(fs - (frameCount*2));
  println(frameCount);
  float amount = frameCount;
  float step = 360.0 / amount;
  push();
  translate(width/2, height/2);
  for (int i = 0; i < amount; i++) {
    float rotation = step*i;
    push();
    rotate(radians(rotation + frameCount));
    text(txt, 80, 0);
    pop();
  }
  pop();
}
