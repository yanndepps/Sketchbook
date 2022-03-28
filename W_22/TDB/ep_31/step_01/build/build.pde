/*
 * © thedotisblack.com
 * Not Random Grid 01
 * step_01
 * add margins to align the grid
 * use map() to change the corners with a for loop
 */

color bc = color(255);
color fc = color(40);
int nw = 620;
int nh = 620;
float xStep;
float yStep;
float rectSize;
float mx, my;

void settings() {
  size(nw, nh);
  smooth();
}

void setup() {
  surface.setLocation(25, 25);
  // ---
  xStep = ceil( nw * 0.126 );
  yStep = ceil( nh * 0.126 );
  rectSize = round( xStep * 0.7 );
  mx = ceil( nw * 0.05 );
  my = ceil( nw * 0.05 );
  // rectSize = ceil( nw * 0.111 );
  // ---
  noStroke();
  fill(fc);
  rectMode(CENTER);
  // ---
  // println("x steps -> ", xStep);
  // println("y steps -> ", yStep);
  // println("rect size -> ", rectSize);
  // println("margin x -> ", mx);
}

void draw() {
  background(bc);
  // ---
  for (float x = mx; x < nw; x += xStep) {
    for (float y = my; y < nh; y += yStep) {
      // float rectEdge = map(x+y, mx+my, nw+nh, 5, rectSize);
      float rectEdge = map(sin(radians(x+y)), -1, 1, 5, rectSize);
      rect(x, y, rectSize, rectSize, rectEdge);
    }
  }
}
