/*
 * dynamic waveforms with nested for-loops
 * variation #04
 * interferences
 */

float r;

void setup() {
  size(640, 640);
  noStroke();
  fill(#f4f4f4);
  r = 5;
}

void draw () {
  background(0);
  // ---
  float tiles_x = 64;
  float tiles_y = 64;
  float tile_w = width / tiles_x;
  float tile_h = height / tiles_y;
  float offset = 10.0;
  float mult_x = 1.5;
  float mult_y = 1.8;
  float mag = tile_w * 2.5;
  // println("mag -> ", mag);
  // ---
  translate(tile_w / 2, tile_h / 2);
  // ---
  for (int x = 0; x < tiles_x; x++) {
    for (int y = 0; y < tiles_y; y++) {
      float wave_x = sin(radians(frameCount + x * ( offset * mult_x ))) * mag;
      float wave_y = sin(radians(frameCount + y * ( offset * mult_y ))) * mag;
      // ---
      pushMatrix();
      translate(tile_w * x + wave_x, tile_h * y + wave_y);
      // ellipse(0, 0, tile_w / 4, tile_h / 4);
      ellipse(0, 0, r, r);
      popMatrix();
    }
  }
}
