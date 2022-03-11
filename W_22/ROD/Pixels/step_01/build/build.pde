/*
 * Pixels & Images
 * step_01 -> PImage
 * PImage is not an ordinary data type.
 * Images are so-called “objects”, which provide many helpful functions
 * in addition to the ability to store pixel data.
 */

PImage img;
color bg = #333333;

void setup() {
  size(512, 512);
  img = loadImage("pix_01.jpg");
  img.filter(GRAY);
}

void draw() {
  background(bg);
  imageMode(CENTER);
  image(img, width/2, height/2);
}
