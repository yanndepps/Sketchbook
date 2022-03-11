/*
 * Pixels & Images
 * step_06 -> masking with PGraphics
 */

PImage img;
PGraphics mask;

color bg = #000000;
color fg = #ffffff;

void setup() {
  size(512, 512);
  // ---
  img = loadImage("pix_01.jpg");
  img.filter(GRAY);
  // ---
  mask = createGraphics(img.width, img.height);
}

void draw() {
  background(bg);
  // ---
  mask.beginDraw();
  mask.background(bg);
  mask.fill(fg);
  mask.noStroke();
  mask.translate(width/2, height/2);
  mask.rectMode(CENTER);
  mask.rotate(radians(frameCount * 4));
  mask.rect(0, 0, 400, 100);
  mask.endDraw();
  img.mask(mask);
  image(img, 0, 0);
}
