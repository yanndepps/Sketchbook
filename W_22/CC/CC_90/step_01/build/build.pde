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

int index(int x, int y) {
  return x + y * h_kong.width;
}

void draw() {
  h_kong.loadPixels();
  for (int y = 0; y < h_kong.height-1; y++) {
    for (int x = 1; x < h_kong.width-1; x++) {
      color pix = h_kong.pixels[index(x, y)];

      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);

      int factor = 1;
      int newR = round(factor * oldR / 255) * ( 255 / factor );
      int newG = round(factor * oldG / 255) * ( 255 / factor );
      int newB = round(factor * oldB / 255) * ( 255 / factor );
      h_kong.pixels[index(x,y)] = color(newR, newG, newB);

      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;

      // .1
      int index = index(x+1, y);
      color c = h_kong.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      r = r + errR * 7 /16.0;
      g = g + errG * 7 /16.0;
      b = b + errB * 7 /16.0;
      h_kong.pixels[index] = color(r,g,b);

      // .2
      index = index(x-1, y+1);
      c = h_kong.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 3 /16.0;
      g = g + errG * 3 /16.0;
      b = b + errB * 3 /16.0;
      h_kong.pixels[index] = color(r,g,b);

      // .3
      index = index(x, y+1);
      c = h_kong.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 5 /16.0;
      g = g + errG * 5 /16.0;
      b = b + errB * 5 /16.0;
      h_kong.pixels[index] = color(r,g,b);

      // .4
      index = index(x+1, y+1);
      c = h_kong.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 1 /16.0;
      g = g + errG * 1 /16.0;
      b = b + errB * 1 /16.0;
      h_kong.pixels[index] = color(r,g,b);
    }
  }
  h_kong.updatePixels();
  image(h_kong, 512, 0);
}
