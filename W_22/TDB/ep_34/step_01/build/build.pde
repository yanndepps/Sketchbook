/*
 * (C) thedotisblack.com
 * ep_34 -> Op art with rect and polygon
 * step_01
 *
 * begin with a for() loop where i is decremented
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
  smooth();
  rectMode(CENTER);
}

void draw() {
  background(bg);
  // ---
  translate(width/2, height/2);
  for (float i = iMax; i >= 0; i-=iMax/50) {
    fill(fc);
    stroke(sc);
    rect(x, 0, i, i);
  }
}
