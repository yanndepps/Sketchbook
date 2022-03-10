/*
 * TypeMachines -> step_07
 * String methods
 *
 * Strings in Processing are so-called objects,
 * which is why the word String is capitalized
 * */

PFont thing;
String city = "Oslo";
float fs; // font size

void setup() {
  size(620, 620);
  smooth();
  // ---
  thing = createFont("thing.otf", 1000, true);
  fs = ceil( width * 0.6 );
  // println("font size -> ", fs);
}

void draw() {
  background(#333333);
  fill(#f4f4f4);
  // ---
  textFont(thing);
  textSize(fs);
  textAlign(CENTER, CENTER);
  // text(city.toUpperCase(), width/2, height/2-30);
  // text(city.toLowerCase(), width/2, height/2-30);
  // text(city.length(), width/2, height/2-30);
  text(city.charAt(3), width/2, height/2-30);
  // ---
  // stroke(#ff0000);
  // strokeWeight(1);
  // line(0, height/2, width, height/2);
}
