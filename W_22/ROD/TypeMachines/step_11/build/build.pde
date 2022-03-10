/*
 * TypeMachines -> step_11
 * example -> newsticker
 * */

PFont thing;
float fs; // font size
float lh; // line height
color fg = #f4f4f4;
color bg = #333333;

void setup() {
  size(620, 620);
  smooth();
  noStroke();
  // ---
  thing = createFont("thing.otf", 1000, true);
  fs = ceil( width * 0.4 );
  lh = ceil( width * 0.0016 );
  // println("font size -> ", fs);
  // println("line height -> ", lh);
}

void draw() {
  background(bg);
  fill(fg);
  // ---
  textFont(thing);
  textSize(fs);
  textAlign(LEFT, TOP);
  // ---
  text(text1.toUpperCase(), -frameCount, 0);
  // ---
  fill(fg);
  rect(0, height/3, width, height/3);
  fill(bg);
  text(text2.toUpperCase(), -frameCount*2, 200+lh);
  // ---
  fill(fg);
  text(text3.toUpperCase(), -frameCount*3, 420+lh+lh);
}
