/*
 * Pixels & Images
 * step_10 -> threshold
 *
 * this example uses the brightness value of each pixel of the image to decide
 * whether to fill the tile in the grid white or black.
 * This creates a threshold effect.
 */

PImage img;

color bg = #000000;
color fg = #ffffff;

void setup() {
  size(512, 512);
  // ---
  img = loadImage("pix_01.jpg");
  img.filter(GRAY);
  // ---
}

void draw() {
  background(bg);
  // noStroke();
  // ---
  float tiles_x = floor( width * 0.12 );
  float tiles_y = floor( height * 0.12 );
  float tile_w = width / tiles_x;
  float tile_h = height / tiles_y;
  float wave = map(sin(radians(frameCount)), -1, 1, 0, 255);
  // ---
  for (int x = 0; x < tiles_x; x++) {
    for (int y = 0; y < tiles_y; y++) {
      int px = int(x * tile_w);
      int py = int(y * tile_h);
      color c = img.get(px, py);
      float b = brightness(c);
      // ---
      if (b < wave) {
        stroke(bg);
        fill(bg);
      } else {
        stroke(fg);
        fill(fg);
      }
      rect(x * tile_w, y * tile_h, tile_w, tile_h);
    }
  }
}
