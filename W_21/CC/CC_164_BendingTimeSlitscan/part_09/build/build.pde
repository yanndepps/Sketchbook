// --- #164 -> Bending Time Slitscan --- //
// using the copy() function
// Horizontal Time Displacement Slitscan

import processing.video.*;
Capture cam;

int w = 5; // 10
int y = 0;
PImage[] history;
int historyIndex = 0;
int offset = 0;

void setup() {
  size(640, 480);
  background(33);
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  history = new PImage[width/w];
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
    int x = i * w;
    int currentIndex = ( i + offset ) % history.length;
    copy(history[currentIndex], x, 0, w, height, x, 0, w, height);
  }
  offset++;
  history[historyIndex].copy(cam, 0, 0, width, height, 0, 0, width, height);
  historyIndex = ( historyIndex + 1 ) % history.length;
}
