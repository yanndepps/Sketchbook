/*
* creative coding : animate the pixel sorting (also help with the time it may takes)
* thiinks to figure out later :
* sortings different than brightness and hue ?
* ordering different than horizontal ?
* sort only part of the image/pixels ?
* now, can we ouput hires files ? YES : hires png's here ! key : h || H
*/

// ------ imports ------

import generativedesign.*;
import processing.opengl.*;
import processing.pdf.*;
import java.util.Calendar;

// ------ initial parameters and declarations ------

PImage img;
PImage sorted;
int index = 0;

// ------ image output ------

boolean saveOneFrame = false;
boolean savePDF = false;
int qualityFactor = 3;
TileSaver tiler;

// ------

void setup() {
	size(500, 500, P3D);
	hint(DISABLE_DEPTH_TEST);

	tiler = new TileSaver(this);
    smooth();
	img = loadImage("sval.jpeg");
	sorted = createImage(img.width, img.height, RGB);
	sorted.loadPixels();
	img.loadPixels();
	sorted = img.get();
}


// ------


void draw() {
	 // ------ image output ------
  	if(tiler==null) return; 
  	tiler.pre();

	if (savePDF) {
    	beginRaw(PDF, timestamp()+".pdf");
  	}
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

  // draw next tile for high quality output
  tiler.post();
}

void keyPressed(){
  if(key=='s' || key=='S') {
    saveOneFrame = true; 
  }
  if(key=='p' || key=='P') {
    savePDF = true; 
    saveOneFrame = true; 
    println("saving to pdf - starting (this may take some time)");
  }
  if (key =='h' || key == 'H') {
    tiler.init(timestamp()+".png", qualityFactor);
  }

  if(key==' ') {
    freeze = !freeze;
    if (freeze) noLoop();
    else loop();
  }

}

// timestamp

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}


// ------ end ------
