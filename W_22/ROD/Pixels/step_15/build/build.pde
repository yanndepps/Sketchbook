/*
 * Pixels & Images
 * step_15 -> random collage generator
 */

import java.io.File;
String[] imageFileNames;
PImage[] images;

color bg = #000000;
color fg = #f1f1f1;

void setup() {
  size(512, 512);
  // ---
  java.io.File folder = new java.io.File(dataPath("images"));
  imageFileNames = folder.list();
  images = new PImage[imageFileNames.length];
  println("loading...");
  // load the image-files and push them to images-arrayList
  for (int i = 0; i < imageFileNames.length; i++) {
    String filename = imageFileNames[i];
    PImage temp = loadImage("data/images/"+filename);
    temp.resize(width, height);
    temp.filter(GRAY);
    images[i] = temp;
  }
  println(images.length + " images loaded");
  frameRate(30);
}

void draw() {
  background(bg);
  fill(fg);
  noStroke();
  // ---
  for (int i = 0; i < images.length; i++) {
    if (random(1) < 0.9) {
      PImage img = images[i];
      PGraphics mask = createGraphics(width, height);
      // blendMode(LIGHTEST);
      blendMode(SCREEN);
      // blendMode(ADD);
      mask.beginDraw();
      mask.rectMode(CENTER);
      mask.background(bg);
      mask.fill(fg);
      mask.noStroke();
      float x = random(width);
      float y = random(height);
      float w = random(width);
      float h = random(height);
      mask.rect(x,y,w,h);
      mask.endDraw();
      // ---
      img.mask(mask);
      image(img, 0, 0);
      // ---
      fill(#ffff00);
      noStroke();
      rectMode(CENTER);
    }
  }
  saveFrame("out/collage_###.jpg");
  if (frameCount >= 20) exit();
}
