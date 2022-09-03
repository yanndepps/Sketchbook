int tilesX = 10;
int tilesY = 10;

float mag;

void setup() {
  size(900, 900, P3D);
}

void draw() {

  float mag = 400;
  background(#f1f1f1);
  fill(#000000);
  noStroke();

  push();
  translate(width/2, height/2);

  rotateY(radians(frameCount));
  rotateX(radians(frameCount));

  for (int x = 0; x < tilesX; x++) {
    for (int y = 0; y < tilesY; y++) {

      float posX = map(x, 0, tilesX, -mag, mag);
      float posY = map(y, 0, tilesY, -mag, mag);

      push();
      translate(posX, posY);
      circle(0, 0, 22);
      pop();
    }
  }

  pop();
}
