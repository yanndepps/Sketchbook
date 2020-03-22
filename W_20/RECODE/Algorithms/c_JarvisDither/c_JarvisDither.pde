/*
 * ::::::::::::::::
 * Pixel Algorithms
 * ::::::::::::::::
 *
 * Sketch : JarvisDitherClass
 *
 * Summary : A class for applying Jarvis-Judice-Ninke dithering to an image.
 * REFS :  More coming soon about this at www.fabprojects.codes
 *
 */
import java.util.Date;
import java.text.*;

/////////////////////////// GLOBALS ////////////////////////////

PImage img;
JarvisDither ditherImage;

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
  ditherImage = new JarvisDither( img );
  
  // @param : image gamma correction (zero==no correction)
  ditherImage.computeJarvisDither(0.5);
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