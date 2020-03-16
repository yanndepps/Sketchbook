/*
 * ::::::::::::::::
 * Pixel Algorithms
 * ::::::::::::::::
 *
 * Sketch : FloydDitherClass_01
 *
 * Summary : A class for applying Floyd-Steinberg dithering to an image.
 * REFS :  More coming soon about this at www.fabprojects.codes
 *
 */


/////////////////////////// GLOBALS ////////////////////////////

PImage img;
FloydDither ditherImage;

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
  ditherImage = new FloydDither( img );
  
  // @param : image gamma correction
  ditherImage.computeFloydDither(0.53);
  ditherImage.drawImage();
}

/////////////////////////// DRAW ////////////////////////////
void draw() {
  //background(255);

}

/////////////////////////// FUNCTIONS ////////////////////////////