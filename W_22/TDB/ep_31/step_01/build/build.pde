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
float alpha;

void settings() {
  size(nw, nh);
  smooth();
}

void setup() {
  surface.setLocation(25, 25);
  // ---
  mx = ceil( nw * 0.05 );
  my = ceil( nw * 0.05 );
  xStep = ceil( nw * 0.111 );
  yStep = ceil( nh * 0.111 );
  // rectSize = round( xStep * 0.8 );
  rectSize = ceil( nw * 0.10 );
  // ---
  noStroke();
  fill(fc);
  rectMode(CENTER);
  // ---
  println("x steps -> ", xStep);
  println("y steps -> ", yStep);
  println("rect size -> ", rectSize);
  println("margin x -> ", mx);
}

void draw() {
  background(bc);
  // ---
  for (float x = mx; x < nw; x += xStep) {
    for (float y = my; y < nh; y += yStep) {
      float gridAlpha = map(sin(radians(x*y+alpha)), 0, 1, 0, 90);
      float rectEdge = map(sin(radians(gridAlpha)), -1, 1, 5, rectSize-10);
      fill(0, 255-rectEdge*3);
      rect(x, y, rectSize, rectSize, rectEdge);
    }
  }
  alpha += 2;
}
