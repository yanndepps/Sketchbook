/*
 * (C) thedotisblack.com
 * ep_34 -> Op art with rect and polygon
 * step_00
 *
 * variables and setup()
 */

float angle;
float x = 0;
float iMax = 1100;
float polygonNum = 4;
color bg = color(33);

void setup() {
  size(620, 620, P2D);
  surface.setLocation(25, 35);
  smooth();
  rectMode(CENTER);
}

void draw() {
  background(bg);
  // ---
}
