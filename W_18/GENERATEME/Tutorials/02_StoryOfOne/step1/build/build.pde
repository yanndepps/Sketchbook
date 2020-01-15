/*
plot of noise function using vertex.
*/
// --- vars ---

float yoff = 0.0;

// --- setup&draw ---
void setup() {
  size(800, 800);
  smooth();
  noFill();
  stroke(233, 131, 45);
  makeme();
}

void draw() {

}

// --- functions ---

void makeme() {
  background(23, 67, 88);
  strokeWeight(2*noise(20, 200));
  beginShape();
  float xoff2 = 0;
  for (float x = 0; x <= width; x += 5) {
    float y = map(noise(xoff2, yoff*20), 0, 1, 20, 800);
    vertex(x, y);
    xoff2 += random(0.01, 0.05);
  }
  yoff += 0.01;
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}

void keyPressed() { saveFrame("f####.png"); }
void mousePressed() { makeme(); }

// --- end ---
