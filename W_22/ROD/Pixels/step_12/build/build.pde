/*
 * Pixels & Images
 * step_12 -> rasterization with wave-motion
 */

PImage img;

color bg = #000000;
color fg = #f1f1f1;

void setup() {
  size(512, 512);
  // ---
  img = loadImage("pix_01.jpg");
  img.filter(GRAY);
  // ---
}

void draw() {
  background(bg);
  fill(fg);
  noStroke();
  ellipseMode(CORNER);
  // ---
  float tiles_x = floor( width * 0.48 );
  float tiles_y = floor( height * 0.48 );
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
      float s = map(b, 0, 255, 0, tile_w);
      // ---
      float wave = map(tan(radians((frameCount * 2) + x + y)), -1, 1, -20, 20);
      ellipse(x * tile_w + wave, y * tile_h, s, s);
    }
  }
}
