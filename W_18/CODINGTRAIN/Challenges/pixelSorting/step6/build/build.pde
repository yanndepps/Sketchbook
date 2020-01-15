/*
* creative coding : animate the pixel sorting (also help with the time it may takes)
* thiinks to figure out later :
* sortings different than brightness and hue ?
* ordering different than horizontal ?
* sort only part of the image/pixels ?
* now, can we ouput hires files ? pdf here !
*/

import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

PImage img;
PImage sorted;
int index = 0;
int qf = 1;			// no real use...

void settings() {
	size(500*qf, 500*qf, JAVA2D);
}

void setup() {
	
    smooth();
	img = loadImage("sval.jpeg");
	sorted = createImage(img.width, img.height, RGB);
	sorted.loadPixels();
	img.loadPixels();
	sorted = img.get();
}





void draw() {
	if (savePDF) beginRecord(PDF, timestamp()+".pdf");
	background(33);
	println("frameRate: "+frameRate);

	beginShape();
 	// selection sort
 	for (int n = 0; n < 100; ++n) {
	float record = -1; 
	int selectedPixel = index;
	for (int j = index; j < sorted.pixels.length; ++j) {
		//the color at that particular pixel
		color pix = sorted.pixels[j];
		//sort by hue, average of the rgb value
		float b = hue(pix);
		if (b > record) {
			selectedPixel = j;
			record = b;
		}
	}

	// once the loop is finished, swap the selected pixel with index
	color temp = sorted.pixels[index];
	sorted.pixels[index] = sorted.pixels[selectedPixel];
	sorted.pixels[selectedPixel] = temp;

	if (index < sorted.pixels.length -1) {
		index++;
	}
}
	sorted.updatePixels();
	image(sorted, 0, 0);
 	endShape();

 	if (savePDF) {
    	savePDF = false;
    	endRecord();
  }
}

void keyPressed() {
  if (key=='p' || key=='P') savePDF = true;
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}


//---
