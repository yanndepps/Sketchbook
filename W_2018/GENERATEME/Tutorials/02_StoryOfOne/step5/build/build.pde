/*
step5 : adjustments
random a little the beginning and end of the arc.
provide variable shape_closed to make two options:
one with closed circle, another one open.
*/
// --- vars ---

float yoff = random(1.0);
boolean shape_closed = true;

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

void makeOptions() {
  shape_closed = random(1)<0.5 ? true : false;
}

void makeme() {
  background(20);
  translate(400, 400);
  makeOptions();
  for (int iter = 0; iter < 3000; iter++) {
    stroke(240, random(5.0, 20.0));
    strokeWeight(random(1.0));
    float xoff = random(1.0);
    beginShape();
    for (float ang = random(0.2); ang < random(0.8, 0.9)*TWO_PI; ang += random(TWO_PI/200.0)) {
      float r = map(noise(xoff, yoff*5.0), 0, 1, 20, 400);
      float x = r * cos(ang);
      float y = r * sin(ang);
      vertex(x, y);
      xoff += random(0.01, 0.05);
    }
    yoff += random(0.01, 0.05);
    if(shape_closed) endShape(CLOSE); else endShape();
  }
}

// void keyPressed() { saveFrame("f####.png"); }
void mousePressed() { makeme(); }

// --- end ---
