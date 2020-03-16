/*
 * ::::::::::::::::
 * Pixel Algorithms
 * ::::::::::::::::
 *
 * Sketch : MatrixDitherClass
 *
 * Summary : A class for applying Bayer Matrix dithering to an image.
 * REFS :  More coming soon about this at www.fabprojects.codes
 *
 */
import java.util.Date;
import java.text.*;

/////////////////////////// GLOBALS ////////////////////////////

PImage img;
MatrixDither ditherImage;

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
  ditherImage = new MatrixDither( img );
  
  // @param : image gamma correction (zero==no correction)
  // @param : Bayer matrix type >
  // 2X2 || 4X4 || 8X8 || 4XCluster
  ditherImage.computeMatrixDither(0.9, "8X8");
  ditherImage.drawImage();
}

/////////////////////////// DRAW ////////////////////////////
void draw() {
  //background(255);

}

/////////////////////////// FUNCTIONS ////////////////////////////
void keyPressed() {
  if (key == 's') {
    String time = getTime();
    saveFrame("iteration_"+time+"_"+ditherImage.DType+".png"); 
  }
}


String getTime() {
  Date dNow = new Date( );
  SimpleDateFormat time = new SimpleDateFormat ("YYMMhhmmss");
  //println(time.format(dNow));
  String t = time.format(dNow);
  return t;
}