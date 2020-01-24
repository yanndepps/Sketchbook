import processing.video.*;

Capture video;
PImage backgroundImage;
float threshold;

void setup() {
  size(800, 800);
  video = new Capture(this, 800, 800, Capture.list()[0]);
  backgroundImage = createImage(800, 800, RGB);
  video.start();
  /* printArray(Capture.list()); */
  noCursor();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  threshold = 30;
  loadPixels();
  video.loadPixels();

  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int loc = x + y*video.width;
      color fgColor = video.pixels[loc];
      color bgColor = backgroundImage.pixels[loc];

      float r1 = red(fgColor);
      float g1 = green(fgColor);
      float b1 = blue(fgColor);
      float r2 = red(bgColor);
      float g2 = green(bgColor);
      float b2 = blue(bgColor);

      float diff = dist(r1, g1, b1, r2, g2, b2);
      if (diff > threshold) { pixels[loc] = fgColor; }
    }
  }
  updatePixels();
}

void mousePressed() {
  backgroundImage.copy(video, 0,0, video.width, video.height,
                       0,0, video.width, video.height);
  backgroundImage.updatePixels();
  background(0);
}
