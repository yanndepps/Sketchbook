/*
 * FVS
 * draw the number "9" on a 9-module grid.
 * step_01
 */

color bg = color(0, 15, 33);
color from = #ED0DD9; // tendinous fuchsia
color to = #C1C6FC; // isotopic light perwinkle

int gridSize = 182;
float shapeSize = floor( gridSize * 1.00 );
int cols, rows;
float xx, yy;
int mx, my;
float alpha;
float angle[];

void setup() {
  size(620, 620, P2D);
  noStroke();
  rectMode(CENTER);
  // ---
  cols = width/gridSize;
  rows = height/gridSize;
  mx = (width - cols * gridSize)/2 + gridSize/2;
  my = (height - rows * gridSize)/2 + gridSize/2;
  angle = new float[cols*rows];
  // ---
  println("cols, rows -> ", cols + ", " + rows);
  println("mx, my -> ", mx + ", " + my);
  println("shape size -> ", shapeSize);
  println("stroke size -> ", ceil(shapeSize * 0.025));
  // ---
}

void draw() {
  background(bg);
  // ---
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int x = i * gridSize + mx;
      int y = j * gridSize + my;
      // ---
      // println("x -> ", x);
      // println("y -> ", y);
      // ---
      // a grid of squares
      pushMatrix();
      translate(x, y);
      noStroke();
      fill(from);
      rect(0, 0, shapeSize, shapeSize);
      // ---
      for (float n = 0; n < shapeSize; n += shapeSize/4) {
        stroke(to);
        strokeWeight(ceil(shapeSize * 0.025));
        if ( x % 492 == 0 && y % 310 == 0 ) {
          // horizontal lines
          line(-shapeSize/4, (n-shapeSize/2)+shapeSize/8, shapeSize/4, (n-shapeSize/2)+shapeSize/8);
        } else {
          // vertical lines
          line((n-shapeSize/2)+shapeSize/8, -shapeSize/4, (n-shapeSize/2)+shapeSize/8, shapeSize/4);
        }
      }
      popMatrix();

    }
  }
}
