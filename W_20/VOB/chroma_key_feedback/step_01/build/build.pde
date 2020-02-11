// Chroma Key Feedback

import processing.video.*;

Capture video;
PImage backgroundImage;
float threshold;

void setup() {
  size(1280, 720);
  video = new Capture(this, Capture.list()[0]);
  backgroundImage = createImage(1280, 720, RGB);
  video.start();
  // printArray(Capture.list());
  noCursor();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  background(0);
  threshold = 20;
  loadPixels();
  video.loadPixels();
  image(video, 0, 0);
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int loc = x + y * video.width;
      color fgColor = video.pixels[loc];
      color bgColor = backgroundImage.pixels[loc];

      //float r1 = red(fgColor);
      float r1 = fgColor >> 16 & 0xFF;
      //float g1 = green(fgColor);
      float g1 = fgColor >> 8 & 0xFF;
      //float b1 = blue(fgColor);
      float b1 = fgColor & 0xFF;
      //float r2 = red(bgColor);
      float r2 = bgColor >> 16 & 0xFF;
      //float g2 = green(bgColor);
      float g2 = bgColor >> 8 & 0xFF;
      //float b2 = blue(bgColor);
      float b2 = bgColor & 0xFF;

      float diff = dist(r1, g1, b1, r2, g2, b2);
      if (diff > threshold) {
        pixels[loc] = color(255, 255, 255, 10);
      } else {
        pixels[loc] = color(0, 0, 0);
      }
    }
  }
  updatePixels();
}

void mousePressed() {
  //saveFrame("######.png");
  backgroundImage.copy(video, 0, 0, video.width, video.height,
                       0, 0, video.width, video.height);
  backgroundImage.updatePixels();
}
