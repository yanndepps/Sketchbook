/*
 * Pixels & Images
 * step_06 -> masking with PGraphics
 * images can also be masked so that certain areas are cut out of the picture.
 * To do this, you can use a second image that marks the areas to be cut away
 * in white on black. With the mask()-function, which is part of the PImage class,
 * you define which image should be masked or cropped with which mask.
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
