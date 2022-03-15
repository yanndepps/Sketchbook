/*
 * thedotsiblack.com
 * ep_36
 * step_00 -> interpolate colors with lerpColor part #2
 *
 * use a for() loop and fill the shapeSize with more lines
 */

int gridSize = 50;
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
  // println(ceil( shapeSize * 0.055 ));
  // ---
  cols = width/gridSize;
  rows = height/gridSize;
  mx = (width - cols * gridSize)/2 + gridSize/2;
  my = (height - rows * gridSize)/2 + gridSize/2;
  angle = new float[cols*rows];
  // ---
  for (int i = 0; i < cols*rows; i++) {
    alpha += 11;
    angle[i] = alpha;
  }
}

void draw() {
  background(0, 15, 35);
  color from = #ED0DD9; // tendinous fuchsia
  color to = #C1C6FC; // isotopic light perwinkle
  // ---
  for (int i = 1; i < rows-1; i++) {
    for (int j = 1; j < cols-1; j++) {
      int x = j * gridSize + mx;
      int y = i * gridSize + my;
      // ---
      float lerpAmount = map(sin(radians(angle[i*j]+alpha)), -1, 1, 0, 1);
      color interpolate = lerpColor(from, to, lerpAmount);
      // ---
      pushMatrix();
      translate(x, y);
      rotate(radians(angle[i*j]+alpha+45));
      // ---
      for (float n = 0; n < shapeSize; n += 4) {
        stroke(interpolate);
        strokeWeight(ceil(shapeSize * 0.05));
        line(n, -shapeSize/2, n, shapeSize/2);
      }
      popMatrix();
    }
  }
  alpha++;
  // ---
  noFill();
  stroke(#f4f4f4);
  strokeWeight(40);
  rect(width/2, height/2, width, height);
}

void keyPressed() {
  setup();
}
