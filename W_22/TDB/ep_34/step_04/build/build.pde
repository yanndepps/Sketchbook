/*
 * (C) thedotisblack.com
 * ep_34 -> Op art with rect and polygon
 * step_04
 *
 * add depth to the geometry
 */

float angle;
float x = 300;
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
    rect(x, 0, i, i);
    // ---
    noFill();
    stroke(fc);
    strokeWeight(8);
    rect(x, 0, i, i);
    // ---
    fill(colorRange);
    stroke(colorRange);
    strokeWeight(6);
    rect(x, 0, i-12, i-12);
    // ---
    popMatrix();
    angle += 90;
    if (angle > 1070) angle = 0;
  }
}
