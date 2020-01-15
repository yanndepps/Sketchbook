/*
step4 : break the circle
bypass the issue by making the gap wider.
however, sharp edges are unpleasant
*/
// --- vars ---

float yoff = random(1.0);

// --- setup&draw ---
void setup() {
  size(800, 800);
  smooth();
  noFill();
  makeme();
}

void draw() {

}

// --- functions ---

void makeme() {
  background(23, 67, 88);
  translate(400, 400);
  for (int iter = 0; iter < 3000; iter++) {
    stroke(240, random(5.0, 20.0));
    strokeWeight(random(1.0));
    float xoff = random(1.0);
    beginShape();
    for (float ang = 0.0; ang < 0.8*TWO_PI; ang += random(TWO_PI/200.0)) {
      float r = map(noise(xoff, yoff*5.0), 0, 1, 20, 400);
      float x = r * cos(ang);
      float y = r * sin(ang);
      vertex(x, y);
      xoff += random(0.01, 0.05);
    }
    yoff += random(0.01, 0.05);
    endShape(CLOSE);
  }
}

// void keyPressed() { saveFrame("f####.png"); }
void mousePressed() { makeme(); }

// --- end ---
