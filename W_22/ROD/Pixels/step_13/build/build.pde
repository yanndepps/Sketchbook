/*
 * Pixels & Images
 * step_13 -> rasterization in 3D / extrusion
 *
 * use the brightness-value of each pixel to manipulate the z-position.
 */

PImage img;

color bg = #000000;
color fg = #f1f1f1;

void setup() {
  size(512, 512, P3D);
  // ---
  img = loadImage("pix_01.jpg");
  img.filter(GRAY);
  // ---
}

void draw() {
  background(bg);
  fill(fg);
  noStroke();
  rectMode(CENTER);
  // ---
  float tiles_x = floor( width * 0.24 );
  float tiles_y = floor( height * 0.24 );
  // println("tiles_x -> ", tiles_x);
  float tile_w = width / tiles_x;
  float tile_h = height / tiles_y;
  // ---
  push();
  translate(width/2, height/2);
  scale(0.85);
  float rotation = map(sin(radians(frameCount * 2)), -1, 1, -45, 45);
  rotateY(radians(rotation));
  // ---
  for (int x = 0; x < tiles_x; x++) {
    for (int y = 0; y < tiles_y; y++) {
      // pixel pos x
      int px = int(x * tile_w);
      // pixel pos y
      int py = int(y * tile_h);
      // color of the pixel
      color c = img.get(px, py);
      // brightness of the pixel
      float b = brightness(c);
      // scalar for the tiles
      // brightness mapped to a range between 1 and 0
      float s = map(b, 0, 255, 1, 0);
      // position z
      // brightness mapped to a range between -1 and 1
      float z = map(b, 0, 255, -1, 1);
      // magnitude of the tiles on the z-axis
      float mag = 100;
      push();
      translate(x * tile_w - width/2, y * tile_h - height/2, z * mag);
      rect(0, 0, tile_w * s * 1.5, tile_h * s * 1.5);
      pop();
    }
  }
  pop();
}
