/*
 * gallery : led-grid
 */

void setup() {
  size(640, 640);
  frameRate(30);
  // ---
  noStroke();
  smooth();
}

void draw () {
  background(0);
  // ---
  float tiles_x = 16 * 2;
  float tiles_y = 16 * 2;
  // ---
  float tile_w = width / tiles_x;
  float tile_h = height / tiles_y;
  // ---
  float w = map(sin(radians(frameCount)), -1, 1, 0, 3);
  for (int x = 0; x < tiles_x; x++) {
    for (int y = 0; y < tiles_y; y++) {
      float a = map(tan(radians(x*1 + y*1)), -1, 1, -64, 64);
      float c = map(tan(radians(frameCount * 2 + x * w + y * w * a)), -1, 1, 0, 255);
      fill(c);
      rect(x * tile_w, y * tile_h, tile_w, tile_h);
    }
  }
}
