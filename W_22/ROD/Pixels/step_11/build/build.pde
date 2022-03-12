/*
 * Pixels & Images
 * step_11 -> rasterization
 *
 * By determining brightness values, you can control the size of
 * individual raster cells using the map() function.
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
  noStroke();
  ellipseMode(CORNER);
  // ---
  float tiles_x = floor( width * 0.06 );
  float tiles_y = floor( height * 0.06 );
  float tile_w = width / tiles_x;
  float tile_h = height / tiles_y;
  // ---
  for (int x = 0; x < tiles_x; x++) {
    for (int y = 0; y < tiles_y; y++) {
      int px = int(x * tile_w);
      int py = int(y * tile_h);
      color c = img.get(px, py);
      float b = brightness(c);
      // ---
      float s = map(b, 0, 255, 0, 1);
      // ---
      ellipse(x * tile_w, y * tile_h, tile_w * s, tile_h * s);
    }
  }
}
