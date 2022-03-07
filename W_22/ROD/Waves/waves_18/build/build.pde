/*
 * dynamic waveforms with nested for-loops
 * variation #05
 */

float r;

void setup() {
  size(640, 640);
  noStroke();
  fill(#f4f4f4);
  r = 1.5;
}

void draw () {
  background(0);
  // ---
  float tiles_x = 16 * 6;
  float tiles_y = 16 * 6;
  float tile_w = width / tiles_x;
  float tile_h = height / tiles_y;
  float offset = 2.0;
  float mult_x = 1.5;
  float mult_y = 1.0;
  float mag = floor( tile_w * ( 3 * 5 ) );
  // println("mag -> ", mag);
  // ---
  translate(tile_w / 2, tile_h / 2);
  // ---
  for (int x = 0; x < tiles_x; x++) {
    for (int y = 0; y < tiles_y; y++) {
      float wave_x = sin(radians(frameCount * offset + x * mult_x + y * 1)) * mag;
      float wave_y = sin(radians(frameCount * offset + x * mult_y + y * 3)) * mag;
      // ---
      pushMatrix();
      translate(tile_w * x + wave_x, tile_h * y + wave_y);
      // ellipse(0, 0, tile_w / 4, tile_h / 4);
      ellipse(0, 0, r, r);
      popMatrix();
    }
  }
}
