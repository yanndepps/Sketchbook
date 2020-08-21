// downsample video capture
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
  // downsample to about 1 frame per second
  if (frameCount%60 == 0) {
    image(video, 0, 0, width, height);
  }
}
