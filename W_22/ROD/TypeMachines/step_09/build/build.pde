/*
 * TypeMachines -> step_09
 * getting the text-width
 * */

PFont thing;
String str = "OSLO";
float fs; // font size

void setup() {
  size(620, 620);
  smooth();
  // ---
  thing = createFont("thing.otf", 1000, true);
  fs = ceil( width * 0.5 );
  // println("font size -> ", fs);
  println("text width -> ", floor(textWidth(str)));
}

void draw() {
  background(#333333);
  fill(#f4f4f4);
  // ---
  textFont(thing);
  textSize(fs);
  textAlign(CENTER, CENTER);
  text(str, width/2, height/2-35);
}
