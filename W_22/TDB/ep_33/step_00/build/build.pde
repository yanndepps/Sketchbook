/*
 * (C) thedotisblack.com
 * ep_33 -> Drawing Machine ( Difference )
 * step_00
 *
 * variables for margins and grid sizes + drawing styles
 */

float xStep = 100;
float yStep = 20;
float margin_x = 100;
float margin_y = 100;

color bg = color(33);

void setup() {
  size(620, 620);
  surface.setLocation(25, 25);
  strokeCap(CORNER);
  strokeWeight(20);
  blendMode(MULTIPLY);
}

void draw() {
  background(bg);
}
