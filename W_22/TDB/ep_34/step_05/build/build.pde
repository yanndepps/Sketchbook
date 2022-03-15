/*
 * (C) thedotisblack.com
 * ep_34 -> Op art with rect and polygon
 * step_05
 *
 * create a function for regular polygon shapes
 * make sure polygonNum is never below zero
 * polygon should change after x counter steps
 */

float angle;
float x = 0;
float iMax = 1100;
float polygonNum = 4;
// ---
color bg = color(33);
color sc = color(0, 15, 30);
color fc = color(255);

void setup() {
  size(620, 620, P2D);
  surface.setLocation(25, 35);
  smooth(8);
  rectMode(CENTER);
}

void draw() {
  background(bg);
  // ---
  translate(width/2, height/2);
  for (float i = iMax; i >= 0; i-=(iMax + 1)/100) {
    float colorRange = map(i, iMax-500, 0, 255, 0);
    // ---
    pushMatrix();
    rotate(radians(angle));
    // ---
    noFill();
    stroke(sc);
    strokeWeight(24);
    polygon(x, 0, i, polygonNum);
    // ---
    noFill();
    stroke(fc);
    strokeWeight(8);
    polygon(x, 0, i, polygonNum);
    // ---
    fill(colorRange);
    stroke(colorRange);
    strokeWeight(6);
    polygon(x, 0, i-12, polygonNum);
    // ---
    popMatrix();
    angle += 90;
    if (angle > 1070) angle = 0;
  }
  if (x < 300) x+=5;
  if (x >= 300) {
    if (polygonNum > 0) polygonNum -= 0.01;
    if (polygonNum < 0) polygonNum = 0;
  }
}

// void polygon(float x, float y, float radius, float npoints) {
//   beginShape();
//   for (float a = PI/4; a < TWO_PI+PI/4; a += angle) {
//     float sx = x + cos(a) * radius;
//     float sy = y + sin(a) * radius;
//     vertex(sx, sy);
//   }
//   endShape(CLOSE);
// }

void polygon(float x, float y, float radius, float npoints) {
  float angle = TWO_PI/npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
