/*
 * dynamic waveforms with nested for-loops
 * variation #01
 * the waves are driven by the values x and y,
 * creating complex patterns of motion within the grids
 */

float s;

void setup() {
  size(640, 640);
  noStroke();
  fill(#f4f4f4);
  s = 5;
}

void draw () {
  background(0);
  // ---
  float tiles_x = 64;
  float tiles_y = 64;
  float tile_w = width / tiles_x;
  float tile_h = height / tiles_y;
  float offset = 8.8;
  float mult_x = 2.5;
  float mult_y = 2.8;
  float mag = tile_w * 3.2; // 128
  // println("mag -> ", mag);
  // ---
  translate(tile_w / 2, tile_h / 2);
  // ---
  for (int x = 0; x < tiles_x; x++) {
    for (int y = 0; y < tiles_y; y++) {
      float wave = sin(radians(frameCount + x * ( offset * mult_x ) + y * ( offset * mult_y ))) * mag;
      pushMatrix();
      translate(tile_w * x + wave, tile_h * y);
      // ellipse(0, 0, tile_w / 4, tile_h / 4);
      ellipse(0, 0, s, s);
      popMatrix();
    }
  }
}
