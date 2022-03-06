/*
 * exloring waves : #04
 * use shader as a painting texture
 */

PShader shader;

int w = 512;
int h = 512;
float radius = 1.0;
float mag = ( w * 0.45 ) - radius;

void settings() {
  size(w, h, P3D);
  smooth();
}

void setup() {
  background(0);
  noStroke();
  shader = loadShader("shader.frag");
}

void draw() {
  // ---
  shader.set("u_resolution", float(width), float(height));
  shader.set("u_time", millis() / 1000.0);
  shader(shader);
  // ---
  translate(width/2, height/2);
  for (int i = 0; i < 100; i++) {
    float w = map(sin(radians(frameCount)), -1, 1, -100, 100);

    float wave1 = map(sin(radians(frameCount * 0.8 + i + w)), -1, 1, -mag, mag);
    float wave2 = map(cos(radians(frameCount * 0.2 + i)), -1, 1, -mag, mag);

    // float wave1 = map(tan(radians(frameCount * 0.8 + i + w)), -1, 1, -mag/4, mag/4);
    // float wave2 = map(tan(radians(frameCount * 0.2 + i)), -1, 1, -mag * 0.95, mag * 0.95);

    float c = map(sin(radians(frameCount * 5 + i)), -1, 1, 0, 255);

    // fill(c, 0, 100, 64);
    // fill(255, 128);

    // ellipse(wave1, wave2, radius*2, radius*2);
    rect(wave1, wave2, radius*2, radius*2);
  }
}
