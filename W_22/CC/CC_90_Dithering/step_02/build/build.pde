/*
 * exploring dithering
 * step_02
 * floyd-steinberg
 * by fi graham
 * recoded
 */

// --- glabal vars --- //
boolean export = true;
String savePath = "./export/fsd_oj_pix.jpg";
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
  // primaryColor = color(255);
  primaryColor = color(255, 221, 0);
  // secondaryColor = color(0, 0, 170);
  // secondaryColor = color(0);
  secondaryColor = color(0, 87, 183);
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
  floydSteinberg(img, 1);
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

// --- implement floyd-steinberg dithering algorithm
void floydSteinberg(PImage img, int factor) {
  img.loadPixels();
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color input = img.pixels[index(x, y, img.width)];
      color closest = closestColor(input, factor);
      img.pixels[index(x, y, img.width)] = closest;
      Error error = calculateError(input, closest);
      distributeError(img, error, index(x+1, y, img.width), 7/16.0);
      distributeError(img, error, index(x-1, y+1, img.width), 3/16.0);
      distributeError(img, error, index(x, y+1, img.width), 5/16.0);
      distributeError(img, error, index(x+1, y+1, img.width), 1/16.0);
    }
  }
  img.updatePixels();
}

// --- quantize a color --- //
color closestColor(color input, int factor) {
  return (
          color (
                 closestColorHelper(red(input), factor),
                 closestColorHelper(green(input), factor),
                 closestColorHelper(blue(input), factor)
                 )
          );
}

// --- closestColor helper --- //
int closestColorHelper(float input, int factor) {
  return round(factor * input / 255) * (255 / factor);
}

// --- calculates error given two colors
Error calculateError(color input, color closest) {
  return (
          new Error(
                    red(input) - red(closest),
                    green(input) - green(closest),
                    blue(input) - blue(closest)
                    )
          );
}

// --- distribute error to pixel at specified index --- //
void distributeError(PImage img, Error error, int index, float amount) {
  if (insideImage(img, index)) {
    color current = img.pixels[index];
    Error scaledError = new Error(error, amount);
    img.pixels[index] = addError(current, scaledError);
  }
}

// --- choices if index is inside image pixels array --- //
boolean insideImage(PImage img, int index) {
  if (index >= 0 && index < img.width * img.height) {
    return true;
  }
  return false;
}

// --- add error to a color --- //
color addError(color c, Error error) {
  return(
         color(
               red(c) + error.r,
               green(c) + error.g,
               blue(c) + error.b
               )
         );
}

// --- END --- //
