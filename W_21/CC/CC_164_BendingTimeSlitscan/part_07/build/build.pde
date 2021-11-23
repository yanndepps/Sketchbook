// --- #164 -> Bending Time Slitscan --- //
// using the copy() function
// actually apply transformation to the PImage

import processing.video.*;
Capture cam;

int w = 10; // 10
/* int x = 0; */
float angle = 0;
PImage slice;

void setup() {
  size(640, 480);
  background(33);
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  slice = createImage(w, height, RGB);
  cam.start();
}

void captureEvent(Capture cam) {
  cam.read();
}

void draw() {
  // call copy as a method on the PImage object
  slice.copy(cam, width/2 - w/2, 0, w, height, 0, 0, w, height);
  translate(width/2, height/2);
  /* float angle = map(x, 0, width, 0, TWO_PI); */
  rotate(angle);
  image(slice, 0, 0);
  angle += 0.01;
  /* x = ( x + w ) % width; */
}
