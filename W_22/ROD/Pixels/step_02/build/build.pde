/*
 * Pixels & Images
 * step_02 -> resizing an image
 * reduce the size of large image files.
 * This function should be executed only once, preferably in the setup() area.
 * Here it is important to understand that this function directly affects
 * the pixel data of the image and downscales the image within the runtime of the sketch.
 * This can improve performance tremendously.
 *
 * Important: If you simply want to change the display size of an image,
 * it makes sense to use the scale() function instead.
 *
 * The first parameter defines the width, and the second the height of the image.
 * If one of the parameters is set to 0, the aspect ratio of the image is kept.
 */

PImage img;
color bg = #333333;

void setup() {
  size(512, 512);
  img = loadImage("pix_01.jpg");
  img.filter(GRAY);
  img.resize(width/2, 0);
}

void draw() {
  background(bg);
  imageMode(CENTER);
  image(img, width/2, height/2);
}
