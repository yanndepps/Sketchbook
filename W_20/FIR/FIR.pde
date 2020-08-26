/*
System FIR – SHAPE GRAMMARS
Jannis Maroscheck, 2019
*/

import processing.pdf.*;
import processing.svg.*;

int cols = 5;
int rows = cols; 
float fieldSize;
float outerMargin = 0;

void setup() {
  size(400,400);
  background(255);
  strokeWeight(1);
  //pixelDensity(displayDensity());
  fill(0);
  noStroke();
  rectMode(CENTER);
  
  fieldSize = (float(width) - outerMargin*0) / cols;
  
  run();
}

void draw() {};

void run() {
  translate(outerMargin, outerMargin);
  createFields(rows, cols);
  
  newPath(0);
  //exportPaths(100);
}

void keyPressed() {
  newPath(0);
}

void exportPaths(int num) {
  for (int i = 0; i < num; i++) {
    newPath(i+1);
  }
  println();
  println(num + " paths exported.");
  exit();
}

int iteration = 0;
void newPath(int count) {
  background(255);
  Path p = new Path();
  
  if (!ruleBreak(p)) {
    println(p.name());
    println("-- count : " + count);
    println("-- iterations : " + iteration);
    p.show();
    export(p, count);
    iteration = 0;
  } else {
    iteration++;
    newPath(count);
  }
}
