/*
 * Pixels & Images
 * step_05 -> masking
 */

PImage img, mask;
color bg = #333333;

void setup() {
  size(512, 512);
  // ---
  img = loadImage("pix_01.jpg");
  mask = loadImage("mask_02.jpg");
  // img.filter(GRAY);
  img.filter(THRESHOLD);
  mask.filter(THRESHOLD, 0.3);
  img.mask(mask);
}

void draw() {
  background(bg);
  imageMode(CENTER);
  // ---
  image(img, width/2, height/2);
}
