/*
 * TypeMachines -> step_02
 * styling text
 */

String city = "OSLO";
float ts;

void setup() {
  size(620, 620);
  ts = floor( width/3 );
  println(ts);
}

void draw() {
  background(#f1f1f1);
  fill(0);
  textSize(ts);
  textAlign(CENTER, CENTER);
  // textAlign(CENTER, BOTTOM);
  text(city, width/2, height/2-40);
}
