// --- #164 -> Bending Time Slitscan --- //
// using the copy() function
// Time Displacement Slitscan

import processing.video.*;
Capture cam;

int h = 5; // 10
int y = 0;
PImage[] history;
int historyIndex = 0;
int offset = 0;

void setup() {
  size(640, 480);
  background(33);
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  history = new PImage[height/h];
  for (int i = 0; i < history.length; i++) {
    history[i] = createImage(width, height, RGB);
  }
  cam.start();
}

void captureEvent(Capture cam) {
  cam.read();
}

void draw() {
  for (int i = 0; i < history.length; i++) {
    int y = i * h;
    int currentIndex = ( i + offset ) % history.length;
    copy(history[currentIndex], 0, y, width, h, 0, y, width, h);
  }
  offset++;
  history[historyIndex].copy(cam, 0, 0, width, height, 0, 0, width, height);
  historyIndex = ( historyIndex + 1 ) % history.length;
}
