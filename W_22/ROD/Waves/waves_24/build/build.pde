/*
 * further use cases
 * two waves controlling the amount of tiles
 * distributed in a grid
 */

void setup() {
  size(640, 640);
  frameRate(30);
  fill(#f4f4f4);
  noStroke();
  smooth();
}

void draw () {
  background(0);
  // ---
  float wave_x = sin(radians(frameCount * 0.8));
  float wave_y = cos(radians(frameCount * 0.8));
  // ---
  float tiles_x = int(map(wave_x, -1, 1, 1, 16));
  float tiles_y = int(map(wave_y, -1, 1, 1, 16));
  // ---
  float tile_w = width / tiles_x;
  float tile_h = height / tiles_y;
  // ---
  translate(tile_w / 2, tile_h / 2);
  // ---
  for (int x = 0; x < tiles_x; x++) {
    for (int y = 0; y < tiles_y; y++) {
      pushMatrix();
      translate(x * tile_w, y * tile_h);
      ellipse(0, 0, tile_w, tile_h);
      popMatrix();
    }
  }
}
