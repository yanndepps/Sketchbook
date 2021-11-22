// --- #164 -> Bending Time Slitscan --- //
// using the copy() function
// use live input 
// 10.35

PImage bot;
float angle = 0.0;
int w = 10;
int cols;

void settings() {
  size(512, 512, P2D);
  smooth();
}

void setup() {
  bot = loadImage("pix_02.png");
  cols = width / w;
  /* noLoop(); */
}

void draw() {
  background(33);
  for (int x = 0; x < width; x += w) {
    float factor = map(x, 0, width, 0.1, 2);
    int offset = int(map(sin(angle * factor), -1, 1, 0, cols));
    int sx = ( x + offset * w ) % width;
    copy(bot, sx, 0, w, height, x, 0, w, height);
  }
  angle += 0.01;
}
