/*
 * TypeMachines -> step_06
 * line-height
 * */

PFont thing;
String quote = "If you can't explain it simply,\nyou don't understand it well enough.";
float fs; // font size
float lh; // line height

void setup() {
  size(620, 620);
  smooth();
  // ---
  thing = createFont("thing.otf", 1000, true);
  fs = ceil( width * 0.16 );
  lh = ceil( width * 0.0016 );
  println("font size -> ", fs);
  println("line height -> ", lh);
}

void draw() {
  background(#f1f1f1);
  fill(0);
  // ---
  textFont(thing);
  textSize(fs);
  textLeading(fs * lh);
  textAlign(LEFT, TOP);
  text(quote, 30, 30, width, height);
}
