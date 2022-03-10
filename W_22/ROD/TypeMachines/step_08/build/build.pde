/*
 * TypeMachines -> step_08
 * String concatenation
 *
 * Strings can be composed of several substrings.
 * It does not matter if the composed variable types are Strings, chars, floats or ints.
 * It is only important that at least one of the compound parts is really a String.
 * The partial strings are simply put together with +, just like an addition.
 * */

PFont thing;
String str = "Hi, my name is ";
String name = "Yann";
String greeting = str + name;
String theTime;
float fs; // font size

void setup() {
  size(620, 620);
  smooth();
  // ---
  thing = createFont("thing.otf", 1000, true);
  fs = ceil( width * 0.16 );
  // println("font size -> ", fs);
}

void draw() {
  background(#333333);
  fill(#f4f4f4);
  // ---
  textFont(thing);
  textSize(fs);
  textAlign(CENTER, CENTER);
  theTime = hour() + ":" + minute() + ":" + second();
  text(theTime, width/2, height/2);
}
