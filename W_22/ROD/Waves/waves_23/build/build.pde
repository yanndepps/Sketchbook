/*
 * further use cases
 * wave controlling the amoune of elements ( linear distribution )
 */

void setup() {
  size(640, 640);
  frameRate(30);
  fill(#f4f4f4);
  noStroke();
  smooth(6);
}

void draw () {
  background(0);
  // ---
  translate(0, height/2);
  int amount = int(map(sin(radians(frameCount)), -1, 1, 1, 30));
  float step = width / float(amount);
  translate(step / 2, 0);
  // ---
  for (float i = 0; i < amount; i++) {
    ellipse(i*step, 0, step, step);
  }
}
