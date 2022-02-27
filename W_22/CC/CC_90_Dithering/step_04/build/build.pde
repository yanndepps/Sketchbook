/*
 * exploring dithering
 * step_04
 * patterning
 * by fi graham
 * recoded
 */

// --- glabal vars --- //
boolean export = true;
String savePath = "./export/patterning_oj_pix.jpg";
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
  primaryColor = color(255, 221, 0); // contest color 1
  // secondaryColor = color(0, 0, 170);
  // secondaryColor = color(0);
  secondaryColor = color(0, 87, 183); // contest color 2
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
  patternDithering(img, 3, color(0));
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

// --- implement patterning dither algorithm
void patternDithering(PImage img, int scale, color borderColor) {
  img.loadPixels();
  PImage scaled = scaleDown(img, scale);
  scaled.loadPixels();
  ArrayList<ColorMatrix> matrixes = generateColorMatrixes(scale);
  for (int y = 0; y < scaled.height; y++) {
    for (int x = 0; x < scaled.width; x++) {
      float brightness = brightness(scaled.pixels[index(x, y, scaled.width)]);
      int closest = closestMatrix(brightness, matrixes.size());
      for (int j = 0; j < scale; j++) {
        for (int i = 0; i < scale; i++) {
          img.pixels[index(x * scale + i, y * scale + j, img.width)] = matrixes.get(closest).get(i, j);
        }
      }
    }
  }
  // removes unused pixels
  for (int y = scaled.height * scale; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      img.pixels[index(x, y, img.width)] = borderColor;
    }
  }
  for (int x = scaled.width * scale; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      img.pixels[index(x, y, img.width)] = borderColor;
    }
  }
  img.updatePixels();
}

// --- return a smaller copy of the image --- //
PImage scaleDown(PImage img, int factor) {
  PImage output = img.copy();
  output.resize(img.width/factor, img.height/factor);
  return output;
}

// --- creates color matrixes for patterning --- //
ArrayList<ColorMatrix> generateColorMatrixes(int size) {
  ArrayList<ColorMatrix> matrixes = new ArrayList<ColorMatrix>();
  color w = color(255);
  color b = color(0);
  color[] colors = new color[size * size];
  for (int i = 0; i < colors.length; i++) {
    colors[i] = w; // start with all white pixels
  }
  matrixes.add(new ColorMatrix(colors.clone())); // all white matrix
  int[] indexes = getIndexes(size);
  for (int i = 0; i < indexes.length; i++) {
    colors[indexes[i]] = b;
    matrixes.add(new ColorMatrix(colors.clone()));
  }
  return matrixes;
}

// --- return indexes in order of growing from the top left corner in L shape --- //
int[] getIndexes(int size) {
  int[] indexes = new int[size * size];
  int i = 0;
  int currentSize = 1;
  while (currentSize <= size) {
    for (int y = 0; y < currentSize - 1; y++) {
      indexes[i] = index(currentSize - 1, y, size);
      i++;
    }
    for (int x = 0; x < currentSize; x++) {
      indexes[i] = index(x, currentSize - 1, size);
      i++;
    }
    currentSize++;
  }
  return indexes;
}

// --- helper to find closest matrix given a color input --- //
int closestMatrix(float input, int numberOfMatrixes) {
  return int(map(input, 255, 0, 0, numberOfMatrixes - 1));
}
