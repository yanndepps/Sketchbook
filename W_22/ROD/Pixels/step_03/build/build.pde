/*
 * Pixels & Images
 * step_03 -> scaling
 * To scale an image within the draw()-loop,
 * use the scale() function in combination with pushMatrix() and popMatrix().
 * This way the image is displayed scaled without changing the actual size
 * or resolution of the image.
 */

PImage img;
color bg = #333333;

void setup() {
  size(512, 512);
  // ---
  img = loadImage("pix_01.jpg");
  img.filter(GRAY);
}

void draw() {
  background(bg);
  imageMode(CENTER);
  // ---
  push();
  translate(width/2, height/2);
  scale(1.95);
  image(img, 0, 0);
  pop();
}
