/*
 * thedotsiblack.com
 * ep_36
 * step_03 -> interpolate colors with lerpColor part #2
 *
 * instead of a diagonal lerp defined by angle, define a vertical lerp
 * with the number of rows only.
 */

int gridSize = 70;
float shapeSize = floor( gridSize * 0.72 );
int cols, rows;
float xx, yy;
int mx, my;
float alpha;
float angle[];

// color from = #ED0DD9;
// color to = #C1C6FC;
// color from_2 = #BE03FD;
color from = color(255);
color from_2 = color(0, 15, 35);
color to = color(0, 150, 250);

void setup() {
  size(620, 620, P2D);
  surface.setLocation(30, 30);
  noStroke();
  rectMode(CENTER);
  // ---
  println("stroke weight -> ", ceil( shapeSize * 0.03 ));
  println("shape size -> ", shapeSize);
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
  background(from_2);
  // ---
  for (int i = 1; i < rows-1; i++) {
    float lerpAmount = map(i, 1, rows-1, 0, 1);
    color interpolate = lerpColor(from, to, lerpAmount);
    // ---
    for (int j = 1; j < cols-1; j++) {
      int x = j * gridSize + mx;
      int y = i * gridSize + my;
      // ---
      pushMatrix();
      translate(x, y);
      rotate(radians(angle[i*j]+alpha+45));
      // ---
      for (float n = -shapeSize/2; n < shapeSize/2; n += 8) {
        float lerpAmount_2 = map(n, -shapeSize/2, shapeSize/2, 0, 1);
        color interpolate_2 = lerpColor(from_2, interpolate, lerpAmount_2);
        // ---
        stroke(interpolate_2);
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
