/*
 * further use cases
 * wave inverting colors
 */

void setup() {
  size(640, 640);
  frameRate(30);
  noStroke();
  smooth();
}

void draw () {
  float bg = map(sin(radians(frameCount)), -1, 1, 0, 255);
  float fg = map(sin(radians(frameCount)), -1, 1, 255, 0);
  // ---
  background(bg);
  fill(fg);
  // ---
  translate(width/2, 0);
  // ---
  float h = height / 3;
  float wave_1 = sin(radians(frameCount)) * width / 2;
  rect(wave_1, 0, 25, h);
  // ---
  float wave_2 = map(sin(radians(frameCount)), -1, 1, -160, 160);
  rect(wave_2, h, 25, h);
  // ---
  float wave_3 = map(sin(radians(frameCount)), -1, 1, -width / 2, 0);
  rect(wave_3, h * 2, 25, h);
  // ---
}
