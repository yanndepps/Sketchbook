// --- #164 -> Bending Time Slitscan --- //
// using the copy() function
// slitscan

import processing.video.*;
Capture cam;

int w = 2; // 10
int x = 0;

void settings() {
  size(640, 480, P2D);
  smooth();
}

void setup() {
  background(33);
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("there are no cameras available for capture");
  } else {
    println("available cameras : ");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    // cam can be initialized directly using
    // an alement from the array returned by list()
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }

  // grab slices from the middle
  copy(cam, width/2 - w/2, 0, w, height, x, 0, w, height);
  // every frames, move that slice over by one pixel
  x = ( x + w ) % width;
}
