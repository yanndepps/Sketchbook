/*
 * TypeMachines -> step_10
 * example -> charAt
 * */

PFont thing;
String str = "TYPEMACHINES";
float fs; // font size
color fg = #f4f4f4;
color bg = #333333;

void setup() {
  size(620, 620);
  smooth();
  noStroke();
  // ---
  thing = createFont("thing.otf", 1000, true);
  fs = ceil( width * 0.5 );
  println("font size -> ", fs);
  println("height offset -> ", ceil( fs*0.16 ));
}

void draw() {
  background(bg);
  fill(fg);
  // ---
  int num = int(map(mouseX, 0, width, 0, str.length()));
  char c = str.charAt(num);
  // ---
  textFont(thing);
  textSize(fs);
  textAlign(CENTER, CENTER);
  push();
  translate(width/2, height/2 - (ceil( fs * 0.16 )));
  text(c, 0, 0);
  pop();
  // ---
  push();
  rect(mouseX, 0, 5, height);
  pop();
}
