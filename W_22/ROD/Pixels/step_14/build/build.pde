/*
 * Pixels & Images
 * step_14 -> rasterization & wave-motion
 *
 * use the brightness-value of each pixel to manipulate the z-position.
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
  background(fg);
  fill(bg);
  noStroke();
  // ---
  // float tiles_x = floor( width * 0.48 );
  // float tiles_y = floor( height * 0.48 );
  float tiles_x = 512;
  float tiles_y = 512;
  // println("tiles_x -> ", tiles_x);
  float tile_w = width / tiles_x;
  float tile_h = height / tiles_y;
  // ---
  push();
  translate(tile_w/2, tile_h/2);
  for (int x = 0; x < tiles_x; x++) {
    for (int y = 0; y < tiles_y; y++) {
      float wave_x = map(tan(radians(frameCount + x * 0.1 + y * 0.33)), -1, 1, -20, 20);
      float wave_y = map(tan(radians(frameCount + x * 0.2 + y * 0.1)), -1, 1, -20, 20);
      // ---
      color c = img.get(int(x*tile_w), int(y*tile_h));
      float b = brightness(c);
      float s = map(b, 0, 255, tile_w, 0);
      // ---
      float wave_z = map(tan(radians(frameCount + x + y)), -1, 1, 0, 1);
      color fg = #000000;
      color bg = #f1f1f1;
      // ---
      color theColor = lerpColor(fg, bg, wave_z);
      fill(theColor);
      // ---
      push();
      translate(x * tile_w + wave_x, y * tile_h + wave_y);
      rect(0, 0, s*2, s*2);
      pop();
    }
  }
  pop();
}
