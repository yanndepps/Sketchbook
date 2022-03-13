/*
 * thedotsiblack.com
 * interpolate colors with lerpColor
 * step_08
 *
 * use a line instead of rect()
 */

int gridSize = 50;
float shapeSize = gridSize * 0.7;
int cols, rows;
float xx, yy;
int mx, my;
float alpha;
float angle[];

void setup() {
  // fullScreen();
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
    alpha += 90;
    angle[i] = alpha;
    // angle[i] = random(360);
  }
}

void draw() {
  background(33);
  // color from = color(255);
  // color to = color(0, 150, 250);
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
      // isolate the matrix at each x and y pos
      pushMatrix();
      translate(x, y);
      rotate(radians(angle[i*j]+alpha));
      stroke(interpolate);
      strokeWeight(shapeSize * 0.3);
      line(0, -shapeSize*0.5, 0, shapeSize*0.5);
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

// use keyboard to generate new random array values
void keyPressed() {
  setup();
}
