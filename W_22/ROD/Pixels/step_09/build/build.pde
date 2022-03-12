/*
 * Pixels & Images
 * step_09 -> pixelation
 *
 * In this example, we make use of the get function to determine
 * the brightness value of a pixel.
 * For this we have the brightness() function, which converts a color variable
 * into a float that determines the brightness of the pixel between 0 and 255.
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
  fill(fg);
  // ---
  float tiles_x = floor( width * 0.06 ); // 30px
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
      fill(b);
      rect(x * tile_w, y * tile_h, tile_w, tile_h);
    }
  }
}
