/*
 * ::::::::::::::::
 * Pixel Algorithms
 * ::::::::::::::::
 *
 * Sketch : DITHER CLASS
 *
 * Summary : A class for applying various dithering to an image.
 * REFS :  More coming soon about this at www.area03.bitbucket.io
 *
 */

import java.util.Date;
import java.text.*; // for SimpleDateFormat
import processing.pdf.*;
boolean PDFExport = false;
String time;
int t;
/////////////////////////// GLOBALS ////////////////////////////

PImage img;
Dither ditherImage;

/////////////////////////// SETUP ////////////////////////////
void settings() {
  img = loadImage("flower_yellows.jpg");
  size(img.width, img.height, JAVA2D);
}

void setup() {
  background(0, 0, 33);
  smooth();
  noStroke();
  // @param : the image to dither
  // @param : Type of dither >>> FLOYD || ATKINSON || ORDERED
  ditherImage = new Dither(img, "ORDERED");

}

/////////////////////////// DRAW ////////////////////////////
void draw() {
 background(255);

 if (PDFExport) {
    beginRecord(PDF, "export_###_"+ditherImage.DType+".pdf");
    ditherImage.drawImagePDF();
 }
 background(255);
  if (PDFExport) {
    beginRecord(PDF, "export_###_"+ditherImage.DType+".pdf");
    ditherImage.drawImagePDF();
  }

  ditherImage.computeDither(0.75, 1);
  ditherImage.drawImage();

  if (PDFExport) {
    endRecord();
    println("Finito");
    PDFExport = false;
  }
}

/////////////////////////// FUNCTIONS ////////////////////////////
void keyPressed(){
  if (key == 's') {
    String time = getTime();
    saveFrame("iteration_"+time+"_"+ditherImage.DType+".png"); // save image
  }

  if (key == 'e') {
    PDFExport = !PDFExport;
  }
}

String getTime() {
  Date dNow = new Date( );
  SimpleDateFormat time = new SimpleDateFormat ("YYMMhhmmss");
  //println(time.format(dNow));
  String t = time.format(dNow);
  return t;
}