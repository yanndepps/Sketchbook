/*
 * B3 Biennale des bewegten bildes 2013
* © Stig Møller Hansen
* Source : https://www.youtube.com/watch?v=0raSvWXgCbE
* Mathematica article : https://mathematica.stackexchange.com/questions/24148/how-can-this-image-optical-illusion-be-created-with-mathematica
* B3 Biennale of the Moving Image : https://b3biennale.de/en/
 * Step_02 -> playground
*/

// PImage typography;
float wRatio, hRatio;
int seed = int(random(MAX_INT));
// int seed = 809764480;
// 571146906
// 809764482

void setup() {
  fullScreen();
  // size(2480, 3508);
  // size(620, 620);
  // surface.setLocation(25, 15);
  pixelDensity(displayDensity());
  // typography = loadImage("typography.png");
  wRatio = min(float(width)/float(height), 1);
  hRatio = min(float(height)/float(width), 1);
  noLoop();
  println(pixelWidth);
}

void draw() {
  for (int x = 0; x < pixelWidth; x++) {
    for (int y = 0; y < pixelHeight; y++) {
      // translate cartesian coordinates ( x, y ) to polar coordinates ( radius, angle )
      float xval = map(x, 0, pixelWidth, -wRatio, wRatio);
      float yval = map(y, 0, pixelHeight, -hRatio, hRatio);
      float radius = sqrt(xval*xval + yval*yval);
      float angle = atan2(yval, xval);

      // use for random generations
      randomSeed(seed);

      float r = makeRandom(radius, angle);
      float g = makeRandom(radius, angle);
      float b = makeRandom(radius, angle);

      set(x, y, color(r, g, b));
    }
  }
  // TODO: place typography content here
  // image(typography, 0, 0);
}

float calcVal(float _radius, float _angle, int _angleMultiply, float _pow, float _amplify, int _base, int _spread) {
  // prepping and error prevention
  _radius = max(_radius, 0.01); // radius should not reaches 0
  _radius *= min(wRatio, hRatio); // spiky fx visible to the corners of the sketch
  _pow = max(abs(_pow), 0.05); // spikes go inward and at least 0.05 to avoid artefacts

  float sinVal = sin(
                  log(_radius)
                  * pow(abs(sin(_angle*_angleMultiply)), _pow)
                  * _amplify
);
  return map(sinVal, -1, 1, 0, 255);
}

float makeRandom(float _radius, float _angle) {
 int angleMultiply = int(random(3, 16));
 float pow = random(0.16); // 0.16
 float amplify = random(36); // 36
 int base = int(random(255));
 int spread = int(random(30, 95));
 return calcVal(_radius, _angle, angleMultiply, pow, amplify, base, spread);
}

void keyPressed() {
  if (keyCode == UP) {
    seed++;
    redraw();
  }
  if (keyCode == DOWN) {
    seed--;
    redraw();
  }
  if (key== ' ') {
    // save image
    String filename = "pattern_seed_#" + seed + ".png";
    saveFrame("./data/" + filename);
    println("Saved as -> " + filename);
  }
}
