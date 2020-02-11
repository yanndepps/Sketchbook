// Kandinsky Vision

import processing.video.*;
Capture img;

int matrixSize;
float t = 1;
float s = 0;

void setup() {
  size(1280, 720);
  colorMode(HSB, 360, 100, 100);
  img = new Capture(this, Capture.list()[0]);
  printArray(Capture.list());
  img.start();
  strokeCap(PROJECT);
  stroke(0);
  rectMode(CENTER);
}

void captureEvent(Capture img) {
  img.read();
}

void draw() {
  background(0, 0, 100);
  int t = int(map(mouseY, 0, height, 2, 120));
  matrixSize = width/t;

  for (int x = 0; x < img.width; x += matrixSize) {
    for (int y = 0; y < img.height; y += matrixSize) {
      color c = img.pixels[x + y * img.width];
      float s = map(mouseY, 0, width, 0, 120);
      strokeWeight(s);
      //---
      if (saturation(c) <= 20 && brightness(c) >= 85) {
        line(((width-img.width)/2.5)+x+(matrixSize/2)-(matrixSize/(4*t)), 
          ((width-img.width)/2)+y, ((width-img.width)/2.5)+x+(matrixSize/2)-(matrixSize/(4*t)), 
          ((width-img.width)/2)+y+matrixSize/3);
      }
      //---
      if (brightness(c) <= 10) {
        line(((width-img.width)/2.5)+x+(matrixSize/3), ((width-img.width)/2)+y+(matrixSize/2)-(matrixSize/(4*t))-(matrixSize/3), 
          ((width-img.width)/2.5)+x+(matrixSize/3)+matrixSize/3, ((width-img.width)/2)+y+(matrixSize/2)-(matrixSize/(4*t))-(matrixSize/3));
      }
      //---
      if ((hue(c) < 20 && saturation(c) > 20 && brightness(c) > 10)
        || (hue(c) > 270 && saturation(c) > 20 && brightness(c) > 10)
        || (hue(c) > 70 && hue(c) < 150 && saturation(c) > 20 
        && brightness(c) > 10) || (saturation(c) <= 20 && brightness(c) > 10 && brightness(c) < 85))
      {
        line(((width-img.width)/2.5)+x+(matrixSize/3), ((width-img.width)/2)+y+matrixSize/4, 
          ((width-img.width)/2.5)+x+(matrixSize/3)+matrixSize/4, ((width-img.width)/2)+y+matrixSize/6);
      }
      //---
      if (hue(c) >= 150 && hue(c) <= 70 && saturation(c) > 20 && brightness(c) > 10) {
        line(((width-img.width)/2.5)+x+(matrixSize/3), ((width-img.width)/2)+y+matrixSize/4, ((width-img.width)/2.5)+x+(matrixSize/3)
          + matrixSize/4, ((width-img.width)/2)+y+matrixSize/6);
      }
      //---
      if (hue(c) >= 20 && hue(c) <= 70 && saturation(c) > 20 && brightness(c) > 10) {
        line(((width-img.width)/2.5)+x+(matrixSize/2.5), ((width-img.width)/2)+y+matrixSize/3, 
          ((width-img.width)/2.5)+x+(matrixSize/3) + matrixSize/3 - matrixSize/7, ((width-img.width)/2)+y);
      }
    }
  }
}
