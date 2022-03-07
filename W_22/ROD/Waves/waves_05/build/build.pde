/*
 * sin()
 */

void setup() {
  size(640, 640);
  rectMode(CENTER);
  fill(#ffff00);
  noStroke();
}

void draw () {
  background(0);
  float wave = sin(radians(frameCount)) * 160;
  rect(width/2 + wave, height/2, 170, 600);
}
