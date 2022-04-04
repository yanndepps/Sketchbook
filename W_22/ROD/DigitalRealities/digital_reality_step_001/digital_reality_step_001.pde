float MAGNITUDE = 12000;

float cameraZ = 0;

void setup() {
  size(1920, 1080, P3D);
}

void draw() {
  background(0);

  perspective(PI/3.0, (float)width/height, 1, 100000);

  float tilesX = 100;
  float tilesY = 100;

  float tileW = MAGNITUDE/tilesX;
  float tileH = MAGNITUDE/tilesY;

  fill(#F1F1F1);
  noStroke();


  push();
  translate(width/2, height/2 + 200, cameraZ);
  rotateX(radians(90));

  for (int x = 0; x < tilesX; x++) {
    for (int y = 0; y < tilesY; y++) {

      push();
      translate(tileW/2 - MAGNITUDE/2 + tileW * x, tileH / 2 - MAGNITUDE/2 + tileH * y);
      box(5);
      pop();
    }
  }

  pop();

  if (keyPressed) {
    if (key == 'w') {
      cameraZ += speed;
    } else if (key == 's') {
      cameraZ -= speed;
    }
  }
}
