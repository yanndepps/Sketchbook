// Lines/Format

import processing.video.*;
Capture img;

int matrixsize;
int t = 1;
float s = 0;

void setup() {
  size(1280, 720);
  img = new Capture(this, 1280, 720);
  img.start();
  printArray(Capture.list());
}

void captureEvent(Capture img) {
  img.read();
}

void draw() {
  background(255);
  t = int(map(mouseY, 0, height, 2, 120));
  matrixsize = width/t;

  for (int x = 0; x < img.width; x += matrixsize) {
    for (int y = 0; y < img.height; y += matrixsize) {
      color c = img.pixels[x + y * img.width];
      stroke(0);
      float s = map(mouseX, 0, width, 0, 120);
      strokeWeight(s);
      strokeCap(PROJECT);
      if (((red(c) > 127 && green(c) < 45 && blue(c) < 45)) ||
          ((red(c) < 45 && green(c) > 45 && blue(c) < 45)) ||
          ((red(c) < 210 && red(c) > 45 && green(c) < 210 &&
            green(c) > 45 && blue(c) < 210 && blue(c) > 45))) {
        noStroke();
      }
      //--
      if (red(c) < 45 && green(c) < 45 && blue(c) > 10) {
        noStroke();
      }
      //---
      if (red(c) > 45 && green(c) > 45 && blue(c) < 10) {
        noStroke();
      }
      //---
      if (red(c) > 30 && green(c) > 30 && blue(c) > 30) {
        line(x, y, x, height/2+y);
      }
      //---
      if (red(c) < 66 && green(c) < 66 && blue(c) < 66) {
        line(x, y, width/2+x, y);
      }
      fill(0);
    }
  }
}
