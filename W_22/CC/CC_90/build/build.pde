/*
 * Coding Challenge #90
 * Floyd-Steinberg Dithering
 * 12.36
 */

PImage h_kong;

void setup() {
  size(1024, 512);
  h_kong = loadImage("pix_01.jpg");
  h_kong.filter(GRAY);
  image(h_kong, 0, 0);
}

void draw() {
  h_kong.loadPixels();
  for (int x = 0; x < h_kong.width; x++) {
    for (int y = 0; y < h_kong.height; y++) {
      int index = x + y * h_kong.width;
      color pix = h_kong.pixels[index];

      float r = red(pix);
      float g = green(pix);
      float b = blue(pix);

      int factor = 4;
      int newR = round(factor * r / 255) * ( 255 / factor );
      int newG = round(factor * g / 255) * ( 255 / factor );
      int newB = round(factor * b / 255) * ( 255 / factor );

      h_kong.pixels[index] = color(newR, newG, newB);
    }
  }
  h_kong.updatePixels();
  image(h_kong, 512, 0);
}
