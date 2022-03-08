/*
 * TypeMachines -> step_03
 * import font
 */

PFont thing;
String city = "OSLO";
float ts;

void setup() {
  size(620, 620);
  thing = createFont("thing.otf", 1000, true);
  ts = floor( width * 0.6 );
  smooth();
}

void draw() {
  background(#f1f1f1);
  fill(0);
  textFont(thing);
  textSize(ts);
  textAlign(CENTER, CENTER);
  text(city, width/2, height/2-40);
}
