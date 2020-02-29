/*
 * changing the color circle by moving the mouse
 *
 * MOUSE
 * position x               : saturation
 * position y               : brightness
 *
 * KEYS
 * 1-5                      : number of segments
 * s                        : save png
 * p                        : save pdf
 */

import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

int segCount = 360;
int radius = 300;

void setup() {
  size(800, 800);
}

void draw() {
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");

  noStroke();
  colorMode(HSB, 360, width, height);
  background(360);

  float angleStep = 360/segCount;

  beginShape(TRIANGLE_FAN);
  vertex(width/2, height/2);
  for (float angle=0; angle<=360; angle+=angleStep) {
    float vx = width/2 + cos(radians(angle))*radius;
    float vy = height/2 + sin(radians(angle))*radius;
    vertex(vx, vy);
    fill(angle, mouseX, mouseY);
  }
  endShape();

  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

void keyReleased(){
  if (key=='s' || key=='S') saveFrame(timestamp()+"_##.png");
  if (key=='p' || key=='P') savePDF = true;

  switch(key) {
    case '1':
      segCount = 360;
      break;
    case '2':
      segCount = 45;
      break;
    case '3':
      segCount = 24;
      break;
    case '4':
      segCount = 12;
      break;
    case '5':
      segCount = 6;
      break;
  }
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
