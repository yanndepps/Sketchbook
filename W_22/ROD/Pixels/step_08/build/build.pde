/*
 * Pixels & Images
 * step_08 -> picking colors 02
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
  color c = img.get(mouseX, mouseY);
  noStroke();
  noCursor();
  fill(c);
  rect(width*0.5, 0, width*0.5, height);
  // ---
  fill(#ff0000);
  ellipse(mouseX, mouseY, 8, 8);
}
