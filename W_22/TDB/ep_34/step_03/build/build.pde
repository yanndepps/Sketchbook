/*
 * (C) thedotisblack.com
 * ep_34 -> Op art with rect and polygon
 * step_03
 *
 * at every decrement of 'i' rotate the rect 90 degrees.
 * add push- and popMatrix()
 * remove flickering and modify geometry :
 * 1. limit and reset the angle counter
 * 2. increase slightly the decrements
 * 3. increase the range (iMax) and number of decrements and rect()
 * 4. increase the limit of angle counter
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
    pushMatrix();
    rotate(radians(angle));
    fill(fc);
    stroke(sc);
    strokeWeight(6);
    rect(x, 0, i, i);
    popMatrix();
    angle += 90;
    if (angle > 1070) angle = 0;
  }
}
