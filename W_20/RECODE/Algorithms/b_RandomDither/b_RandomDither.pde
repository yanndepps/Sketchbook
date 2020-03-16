/*
 * ::::::::::::::::
 * Pixel Algorithms
 * ::::::::::::::::
 *
 * Sketch : RandomDitherClass
 *
 * Summary : A class for applying random dithering to an image.
 * REFS :  More coming soon about this at www.fabprojects.codes
 *
 */


/////////////////////////// GLOBALS ////////////////////////////

PImage img;
RandDither ditherImage;

/////////////////////////// SETUP ////////////////////////////
void settings() {
  img = loadImage("flower_yellows.jpg");
  size(img.width, img.height);
}

void setup() {
  background(0, 0, 33);
  smooth();
  noStroke();
  // @param : the image to dither
  ditherImage = new RandDither( img );

  // @param : image gamma correction (zero==no correction)
  // @param : noise diffusion factor (0-5 where 0 equals full random)
  ditherImage.computeRandDither(0.5, 5);
  ditherImage.drawImage();
}

/////////////////////////// DRAW ////////////////////////////
void draw() {
  //background(255);

}

/////////////////////////// FUNCTIONS ////////////////////////////
