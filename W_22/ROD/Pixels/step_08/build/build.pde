/*
 * Pixels & Images
 * step_08 -> picking colors 02
 *
 * Image data is basically nothing more than rasters of pixels.
 * Each pixel has a color value and we can access these color values
 * directly in Processing.
 * So it is possible to query the color of a very specific pixel.
 * And this is the basis for any kind of image manipulation in Processing.
 *
 * The get() function is part of the PImage class and can be used to extract
 * a specific color value from an image.
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
