import processing.video.*;
Capture video;

void setup() {
  size(640, 480);
  video = new Capture(this, width, height);
  video.start();
}

void draw() {
  if (video.available() == true) {
    video.read();
  }
  image(video, 0, 0, width, height);
}