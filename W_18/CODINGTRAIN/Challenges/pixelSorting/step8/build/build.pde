// Daniel Shiffman
// http://codingrainbow.com
// http://patreon.com/codingrainbow
// Code for: https://youtu.be/JUDYkxU6J0o
// sorting each row individually, by brightness

PImage img;
PImage sorted;
int index = 0;

void setup() {
  size(800, 400);

  img = loadImage("dafuck.png");
  sorted = createImage(img.width, img.height, RGB);
  sorted = img.get();
}

void draw() {
  println(frameRate);

  sorted.loadPixels();

  // Selection sort!
  for (int y = 0; y < sorted.height; y++) {

    float record = -1;
    int selectedPixel = index;

    for (int x = index; x < sorted.width; x++) {
      int loc = y * sorted.width + x;
      color pix = sorted.pixels[loc];
      float b = brightness(pix);
      if (b > record) {
        selectedPixel = loc;
        record = b;
      }
    }
    // Swap selectedPixel with i
    color temp = sorted.pixels[y * sorted.width + index];
    sorted.pixels[y * sorted.width + index] = sorted.pixels[selectedPixel];
    sorted.pixels[selectedPixel] = temp;
  }
  if (index < sorted.width -1) {
    index++;
  } else {
    save("sorted.jpg");
    frameRate(0);
  }

  sorted.updatePixels();

  background(0);
  image(img, 0, 0);
  image(sorted, 400, 0);
}