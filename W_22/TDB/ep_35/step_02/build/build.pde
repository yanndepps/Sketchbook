/*
 * thedotsiblack.com
 * interpolate colors with lerpColor
 * step_02
 *
 * interpolate the colors of the grid :
 * 1. declare the colors to interpolate
 * 2. use the lerpColor() function to create new colors at various intervals
 * 3. declare a variable and determine the intervals ( e.g. the grid )
 */

int gridSize = 50; // 46 92 184 276
float shapeSize = gridSize * 0.7;
int cols, rows;
float xx, yy;
int mx, my;
float alpha;
float angle[];

void setup() {
  size(620, 620, P2D);
  surface.setLocation(30, 30);
  noStroke();
  rectMode(CENTER);
  // ---
  cols = width/gridSize;
  rows = height/gridSize;
  mx = (width - cols * gridSize)/2 + gridSize/2;
  my = (height - rows * gridSize)/2 + gridSize/2;
  // angle = new float[cols*rows];
  // ---
  // for (int i = 0; i < cols*rows; i++) {
    // alpha += 11;
    // angle[i] = alpha;
  // }
}

void draw() {
  background(0, 15, 35);
  // color from = color(255);
  // color to = color(0, 150, 250);
  // ---
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int x = j * gridSize + mx;
      int y = i * gridSize + my;
      // ---
      // isolate the matrix at each x and y pos
      pushMatrix();
      translate(x, y);
      rect(0, 0, shapeSize, shapeSize);
      popMatrix();
    }
  }
  // alpha++;
  // ---
  // noFill();
  // stroke(#ffffff);
  // strokeWeight(40);
  // rect(width/2, height/2, width, height);
}
