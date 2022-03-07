/*
 * drawing a circle with sin() & cos()
 */

void setup() {
  size(640, 640);
  background(0);
  rectMode(CENTER);
  fill(#f1f1f1);
  noStroke();
}

void draw () {
  float wave_x = sin(radians(frameCount)) * 300;
  float wave_y = cos(radians(frameCount)) * 300;
  ellipse(width/2 + wave_x, height/2 + wave_y, 10, 10);
}
