/*
 * (C) thedotisblack.com
 * ep_33 -> Drawing Machine ( Difference )
 * step_05
 *
 * interact with the geometry and change sizes
 */

float step_x = 200;
float step_y = 20;
float margin_x = 50;
float margin_y = 50;

color bg = color(255);
color r = color(255, 0, 0);
color b = color(0, 0, 255);

void setup() {
  size(620, 620);
  surface.setLocation(25, 25);
  strokeCap(CORNER);
  strokeWeight(20);
  blendMode(MULTIPLY);
  // noLoop();
}

void draw() {
  background(bg);
  float xStepMax = constrain(mouseX, 10, width);
  // ---
  for (float y = margin_y; y <= height-margin_y; y += step_y) {
    step_x = map(y, margin_y, height-margin_y, 40, xStepMax);
    float xx = map(step_x, 40, 100, 20, step_x-10);
    for (float x = margin_x; x <= width-margin_x; x += step_x) {
      if (x+xx < width-margin_x) {
        // blue line
        stroke(b);
        line(x, y, x+xx, y);
        // red lines
        stroke(r);
        line(width-x, y, width-x-xx, y);
      }
    }
  }
}
