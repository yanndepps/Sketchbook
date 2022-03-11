/*
 * Pixels & Images
 * step_04 -> image filters
 * Processing has a whole set of filters that you can easily apply to images.
 * It is important to understand that most of these filters require a lot of
 * performance and are executed very slowly.
 * It makes sense in almost every case to apply the filters in
 * the setup() area of the sketch.
 */

PImage img;
color bg = #333333;

void setup() {
  size(512, 512);
  // ---
  img = loadImage("pix_01.jpg");
  img.filter(GRAY);
  img.filter(BLUR, 3);
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
