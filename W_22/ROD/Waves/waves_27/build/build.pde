/*
 * gallery : circle something
 */

void setup() {
  size(640, 640);
  frameRate(30);
  // ---
  noFill();
  strokeWeight(8);
  smooth();
}

void draw () {
  background(0);
  // ---
  translate(width/2, height/2);
  for (int i = 0; i < 200; i++) {
    float wave = tan(radians(frameCount + i * 0.1)) * 100;
    float c = map(sin(radians(frameCount * 4 + i)), -1, 1, 0, 255);
    stroke(c);
    ellipse(wave, 0, height * 0.75, height * 0.75);
  }
}
