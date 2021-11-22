// --- #164 -> Bending Time Slitscan --- //
// using the copy() function
// the dimensions of the destination do not have to match the 
// dimensions of the source one.

void settings() {
  size(400, 400, P2D);
  smooth();
}

void setup() {
  // ---
}

void draw() {
  background(33);
  fill(255, 0, 0);
  circle(100, 100, 50);
  copy(0, 0, 200, 200, 200, 200, 200, 200);
}
