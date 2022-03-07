/*
 * further use cases
 * wave controlling the size of an element
 */

void setup() {
  size(640, 640);
  frameRate(30);
  noStroke();
  fill(#f4f4f4);
}

void draw () {
  background(0);
  // ---
  translate(width/2, height/2);
  float wave = map(sin(radians(frameCount)), -1, 1, height * 0.25, height * 0.9);
  circle(0, 0, wave);
}
