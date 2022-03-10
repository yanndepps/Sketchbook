/*
 * TypeMachines -> step_04
 * text frames
 * restrict text elements in a layout
 */

PFont thing;
// String quote = "Be like water, my friend";
String quote = "We suffer more often in imagination than in reality.";
float ts;

void setup() {
  size(620, 620);
  thing = createFont("thing.otf", 1000, true);
  ts = ceil( width * 0.16 );
  println("font size -> ", ts);
  smooth();
}

void draw() {
  background(#f1f1f1);
  fill(0);
  textFont(thing);
  textSize(ts);
  textAlign(LEFT, TOP);
  text(quote, 0, 0, mouseX, height);
  // ---
  noFill();
  stroke(#ff0000);
  strokeWeight(3);
  rect(0, 0, mouseX, height);
}
