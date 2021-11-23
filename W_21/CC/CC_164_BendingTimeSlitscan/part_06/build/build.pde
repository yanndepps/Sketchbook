// --- #164 -> Bending Time Slitscan --- //
// using the copy() function
// add a PImage between source and destination
// draw that PImage onto the destination
// it allows us to add translate(), rotate() and more 
// to further process the results.

import processing.video.*;
Capture cam;

int w = 2; // 10
int x = 0;
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
  image(slice, x, 0);
  x = ( x + w ) % width;
}
