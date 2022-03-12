/*
 * Pixels & Images
 * step_07 -> picking colors
 */

PImage img;

color bg = #000000;
color fg = #ffffff;

void setup() {
  size(512, 512);
  // ---
  img = loadImage("pix_01.jpg");
  img.filter(GRAY);
  // ---
}

void draw() {
  background(bg);
  imageMode(CENTER);
  // ---
  image(img, width/2, height/2);
  noStroke();
  color c = img.get(mouseX, mouseY);
  fill(c);
  ellipse(mouseX, mouseY, 50, 50);
}
