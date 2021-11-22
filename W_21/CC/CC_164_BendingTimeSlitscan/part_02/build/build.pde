// --- #164 -> Bending Time Slitscan --- //
// using the copy() function
// draw an image by copying a sequence of slices
// shuffle the slices !

PImage bot;

void settings() {
  size(512, 512, P2D);
  smooth();
}

void setup() {
  bot = loadImage("pix_02.png");
  noLoop();
}

void draw() {
  background(33);
  int w = 10;
  for (int x = 0; x < width; x += w) {
    int r = int(random(0, width-w));
    copy(bot, r, 0, w, height, x, 0, w, height);
    // show the slices
    /* noFill(); */
    /* stroke(33); */
    /* rect(x, 0, w, height); */
  }
}
