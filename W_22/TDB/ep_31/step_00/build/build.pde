/*
 * © thedotisblack.com
 * Not Random Grid 01
 * step_00
 * create a grid with two for loops for x- and y-axis
 */

color bc = color(255);
color fc = color(40);
int nw = 620;
int nh = 620;
float xStep;
float yStep;
int rectSize;

void settings() {
  size(nw, nh);
  smooth();
}

void setup() {
  surface.setLocation(25, 25);
  // ---
  xStep = ceil( nw * 0.126 );
  yStep = ceil( nh * 0.126 );
  rectSize = ceil( nw * 0.111 );
  // ---
  noStroke();
  fill(fc);
  rectMode(CENTER);
  // ---
  println("x steps -> ", xStep);
  println("y steps -> ", yStep);
  println("rect size -> ", rectSize);
}

void draw() {
  background(bc);
  // ---
  for (int x = 0; x < width; x += xStep) {
    for (int y = 0; y < height; y += yStep) {
      rect(x, y, rectSize, rectSize);
    }
  }
}
