/*
 * exloring waves : #01
 */

int w = 512;
int h = 512;
float radius = 1.0;
float mag = ( w * 0.45 ) - radius;

void settings() {
  size(w, h);
  smooth();
}

void setup() {
  background(0);
  noStroke();
}

void draw() {
  translate(width/2, height/2);
  for (int i = 0; i < 100; i++) {
    float w = map(sin(radians(frameCount)), -1, 1, -100, 100);

    float wave1 = map(sin(radians(frameCount * 0.8 + i + w)), -1, 1, -mag * 0.75, mag * 0.75);
    // float wave2 = map(cos(radians(frameCount * 0.2 + i)), -1, 1, -mag, mag);

    // float wave1 = map(tan(radians(frameCount * 0.8 + i + w)), -1, 1, -mag/4, mag/4);
    float wave2 = map(tan(radians(frameCount * 0.2 + i)), -1, 1, -mag * 0.75, mag * 0.75);

    float c = map(sin(radians(frameCount * 5 + i)), -1, 1, 0, 255);

    // fill(c, 0, 100, 64);
    fill(c, 128);

    // ellipse(wave1, wave2, radius*2, radius*2);
    rect(wave1, wave2, radius*2, radius*2);
  }
}
