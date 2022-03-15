/*
 * (C) thedotisblack.com
 * ep_33 -> Drawing Machine ( Difference )
 * step_02
 *
 * add a map() to control the number of lines in x-axis at each step_y.
 */

float step_x = 100;
float step_y = 20;
float margin_x = 100;
float margin_y = 100;

color bg = color(255);

void setup() {
  size(620, 620);
  surface.setLocation(25, 25);
  strokeCap(CORNER);
  strokeWeight(5);
  blendMode(MULTIPLY);
  noLoop();
}

void draw() {
  background(bg);
  // ---
  for (float y = margin_y; y <= height-margin_y; y += step_y) {
    step_x = map(y, margin_y, height-margin_y, 40, 100);
    for (float x = margin_x; x <= width-margin_x; x += step_x) {
      line(x, y, x+11, y);
    }
  }
}
