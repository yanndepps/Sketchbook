/*
 * further use cases
 * wave controlling the rotation of an element
 */

void setup() {
  size(640, 640);
  frameRate(30);
  // ---
  fill(#f1f1f1);
  noStroke();
  smooth();
  rectMode(CENTER);
}

void draw () {
  background(0);
  // ---
  float wave = sin(radians(frameCount)) * 180;
  pushMatrix();
  translate(width / 2, height / 2);
  rotate(radians(wave));
  rect(0, 0, 50, 320);
  popMatrix();
}
