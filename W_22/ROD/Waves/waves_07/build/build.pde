/*
 * simple waveforms
 */

void setup() {
  size(640, 640);
  background(0);
  rectMode(CENTER);
  fill(#f1f1f1);
  noStroke();
}

void draw () {
  float wave_x = sin(radians(frameCount)) * width * 0.4;
  float wave_y = cos(radians(frameCount * 0.25)) * height * 0.4;
  ellipse(width/2 + wave_x, height/2 + wave_y, 3, 3);
}
