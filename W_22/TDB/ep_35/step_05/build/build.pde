/*
 * thedotsiblack.com
 * interpolate colors with lerpColor
 * step_05
 *
 * because of value 0, the first row and column are not responding to color changes.
 * they show one color only -> i*j = 0*0
 * simple solution: start counting with 1, and to keep the symmetry, remove also
 * the last row and column.
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
  angle = new float[cols*rows];
  // ---
  for (int i = 0; i < cols*rows; i++) {
    alpha += 11;
    // angle[i] = alpha;
    angle[i] = random(360);
  }
}

void draw() {
  background(0, 15, 35);
  color from = color(255);
  color to = color(0, 150, 250);
  // ---
  for (int i = 1; i < rows-1; i++) {
    for (int j = 1; j < cols-1; j++) {
      int x = j * gridSize + mx;
      int y = i * gridSize + my;
      // ---
      float lerpAmount = map(sin(radians(angle[i*j]+alpha)), -1, 1, 0, 1);
      color interpolate = lerpColor(from, to, lerpAmount);
      // ---
      // isolate the matrix at each x and y pos
      pushMatrix();
      translate(x, y);
      rotate(radians(angle[i*j]+alpha));
      fill(interpolate);
      rect(0, 0, shapeSize, shapeSize, 0, shapeSize/2, shapeSize/2, shapeSize/2);
      popMatrix();
    }
  }
  alpha++;
  // ---
  // noFill();
  // stroke(#ffffff);
  // strokeWeight(40);
  // rect(width/2, height/2, width, height);
}

// use keyboard to generate new random array values
void keyPressed() {
  setup();
}
