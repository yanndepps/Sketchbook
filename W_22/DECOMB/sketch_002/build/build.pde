/*
 * sounds from the street
 * https://www.deconbatch.com/2018/03/sounds-from-street.html
 * recoded
 */

// --- vars --- //
int waveCnt;
int frmCntMax;
float seedWaveInit;
float seedShape[];

// --- setup --- //
void setup() {
  size(512, 512);
  colorMode(HSB, 360.0, 100.0, 100.0, 100.0);
  smooth();

  waveCnt = 3; // 6
  frmCntMax = 24 * 9;
  seedWaveInit = random(100);
  seedShape = new float[waveCnt];
  for (int i = 0; i < waveCnt; ++i) {
    seedShape[i] = random(0.0005, 0.05);
  }
}

// --- draw --- //
void draw() {
  float sideLong = width / ( waveCnt - 1 );
  background(0, 0, 90, 100);
  noStroke();
  for (int x = 0; x <= width; x += sideLong) {
    for (int y = 0; y <= height; y += sideLong) {
      if ((x + y) % (sideLong * 2) == 0) {
        fill(0, 0, 90, 100);
      } else {
        fill(0, 0, 10, 100);
      }
      rect(x, y, 180, 180);
    }
  }

  // draw waves
  seedWaveInit += 0.0004; // wave roll speed
  float seedWave = seedWaveInit;
  int lineIndex = 0;

  for (int x = 0; x <= width; x += sideLong) {
    float lastX = x;
    float lastY = -10;
    for (int y = 0; y < height; ++y) {
      float currentY = y;
      for (int weightCnt = 1; weightCnt <= 12; ++weightCnt) {
        float currentX = x + customNoise(seedWave) * weightCnt * 6.0;
        fill(0, 0, 90, 100);
        ellipse(currentX, currentY, 2.0, 2.0);
        fill(0, 0, 10, 100);
        ellipse(width - currentY, currentX, 2.0, 2.0);
        lastX = currentX;
      }
      lastY = currentY;
      seedWave += seedShape[lineIndex]; // wave shape
    }
    ++lineIndex;
  }
  saveFrame("frames/####.png");
  if (frameCount > frmCntMax) {
    exit();
  }
}

float customNoise(float value) {
  return pow(sin(value), 3) * cos(pow(value, 2));
}
