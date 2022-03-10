/*
 * TypeMachines -> step_05
 * line-breaks
 */

PFont thing;
String quote = "Be like water,\nmy friend.";
// String quote = "We suffer more often in imagination than in reality.";
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
  text(quote, 0, 30);
}
