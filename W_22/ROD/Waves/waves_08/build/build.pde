/*
 * work with a for loop and use the incrementor
 * to influence the phase of the waves
 */

void setup() {
  size(640, 640);
  background(0);
  fill(#aaf1f1f1);
  noStroke();
}

void draw () {
  translate(width/2, height/2);
  for (int i = 0; i < 5; i++) {
    float wave_x = sin(radians(frameCount * 0.45 + i)) * width * 0.4;
    float wave_y = cos(radians(frameCount * 0.2 + i)) * height * 0.4;
    ellipse(wave_x, wave_y, 3, 3);
  }
}
