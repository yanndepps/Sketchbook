// GIFs Looper
// ffmpeg -f image2 -framerate 30 -i output/gif-%3d.png noiseloop.gif

int totalFrames = 120;
int counter = 0;
boolean record = false;

void setup() {
  size(400, 400);
}

void draw() {
  float percent = 0;
  if (record) {
    percent = float(counter) / totalFrames;
  } else {
    percent = float(counter % totalFrames) / totalFrames;
  }
   render(percent);
   if (record) {
     saveFrame("output/gif-"+nf(counter, 3)+".png");
     if (counter == totalFrames-1) {
       exit();
     }
   }
   counter++;
}

void render(float percent) {
  float angle = map(percent, 0, 1, 0, TWO_PI);
  background(33);
  translate(width/2, height/2);
  rotate(angle);
  stroke(255);
  noFill();
  rectMode(CENTER);
  square(0, 0, 100);
}
