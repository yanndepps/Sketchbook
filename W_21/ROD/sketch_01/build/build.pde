/*
 * flexible visual system: grid of arcs
 */

color bg = #000000;
color fg = #ff0000;

void setup() {
  size(600, 600);
}

void draw() {
  background(bg);
  fill(fg);
  noStroke();

  float tilesX = 4;
  float tilesY = tilesX;

  float tileW = width / tilesX;
  float tileH = height / tilesY;

  for (int x = 0; x < tilesX; x++) {
    for (int y = 0; y < tilesY; y++) {
      // if (x % 3 == 0) {
      //   fill(fg);
      // } else {
      //   fill(bg);
      // }

      float posX = tileW * x;
      float posY = tileH * y;

      float wave = sin(radians(frameCount + x * 8 + y * 10));
      float mappedWave = map(wave, -1, 1, 0, 5);
      int selector = int(mappedWave);

      pushMatrix();
      translate(posX, posY);
      if (selector == 0) {
        arc(0, 0, tileW*2, tileH*2, radians(0), radians(90));
      } else if (selector == 1) {
        arc(tileW, 0, tileW*2, tileH*2, radians(90), radians(180));
      } else if (selector == 2) {
        arc(tileW, tileH, tileW*2, tileH*2, radians(180), radians(270));
      } else if (selector == 3) {
        arc(0, tileH, tileW*2, tileH*2, radians(270), radians(360));
      } else {
        rect(0, 0, tileW, tileH);
      }
      popMatrix();
    }
  }
}
