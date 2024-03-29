// --- #164 -> Bending Time Slitscan --- //
// using the copy() function
// use live input 

import processing.video.*;
Capture cam;

float angle = 0.0;
int w = 10;
int cols;

void settings() {
  size(640, 480, P2D);
  smooth();
}

void setup() {
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

  cols = width / w;
}

void draw() {
  background(33);
  if (cam.available() == true) {
    cam.read();
  }

  for (int x = 0; x < width; x += w) {
    float factor = map(x, 0, width, 0.1, 2);
    int offset = int(map(sin(angle * factor), -1, 1, 0, cols));
    int sx = ( x + offset * w ) % width;
    copy(cam, sx, 0, w, height, x, 0, w, height);
  }
  angle += 0.01;
}
