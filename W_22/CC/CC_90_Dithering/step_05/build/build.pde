/*
 * exploring dithering
 * step_05
 * perlin noise
 * by fi graham
 * recoded
 */

// --- glabal vars --- //
boolean export = true;
String savePath = "./export/pnoise_pix.jpg";
PGraphics main; // main graphics for exp at different size than screen work
int size = 512; // final exp size including borders
int scale = 1; // working scale, divisor for exp size
int border = 20;
int downSampleFactor = 4; // must be 1 or 2^something

color primaryColor;
color secondaryColor;

PImage img;
String imagePath = "pix_01.jpg";

// --- setup --- //
void setup() {
  size(512, 512);
  setupEnvironment();
  setupColors();
  setupImage();
  processImage();
  drawToMain();
  image(main, 0, 0, width, height);
  if (export) main.save(savePath);
}

// --- set up main graphics and size --- //
void setupEnvironment() {
  // square format is assumed
  // create main graphics before border changes size var
  main = createGraphics(size, size);
  // account for border in size
  size = size - border * 2;
}

// --- set up Color vars --- //
void setupColors() {
  primaryColor = color(255);
  // primaryColor = color(255, 221, 0); // contest color 1
  // secondaryColor = color(0, 0, 170);
  secondaryColor = color(0);
  // secondaryColor = color(0, 87, 183); // contest color 2
}

// --- load image and pre-processing --- //
void setupImage() {
  img = loadImage(imagePath);
  // pre-processing image
  img.resize(size/downSampleFactor, size/downSampleFactor);
  img.filter(GRAY);
}

// --- handle image processing --- //
void processImage() {
  perlinNoiseDither(img);
  changeColor(
              img,
              new ColorPair(color(255), primaryColor),
              new ColorPair(color(0), secondaryColor)
              );
  img = upSampleImage(img, downSampleFactor);
}

// --- handle drawing image in main graphics --- //
void drawToMain() {
  main.beginDraw();
  main.background(secondaryColor);
  main.image(img, border, border);
  main.endDraw();
}

// --- replace first with second colors in ColorPair
void changeColor(PImage img, ColorPair... pairs) {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    for (ColorPair pair : pairs) {
      if (img.pixels[i] == pair.first) {
        img.pixels[i] = pair.second;
      }
    }
  }
  img.updatePixels();
}

// --- scales an image up directly --- //
PImage upSampleImage(PImage in, int factor) {
  in.loadPixels();
  PImage out = createImage(in.width * factor, in.height * factor, ARGB);
  out.loadPixels();
  for (int x = 0; x < out.width; x++) {
    for (int y = 0; y < out.height; y++) {
      int indexIn = x / factor + y / factor * in.width;
      int indexOut = x + y * out.width;
      out.pixels[indexOut] = in.pixels[indexIn];
    }
  }
  out.updatePixels();
  return out;
}

// --- simple function to calculate index of 2d data in one 1d array --- //
int index(int x, int y, int w) {
  return x + y * w;
}

// --- random dither using a perlin noise based off pixel index --- //
void perlinNoiseDither(PImage img) {
  img.loadPixels();
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int index = index(x, y, img.width);
      float brightness = brightness(img.pixels[index]);
      float noise = map(noise(index * 0.0125), 0, 1, 0, 255); // noise scalar -> 0.05
      if (noise < brightness) {
        img.pixels[index] = color(255);
      } else {
        img.pixels[index] = color(0);
      }
      // img.pixels[index] = color(r); // display noise image
    }
  }
}
