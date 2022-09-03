int tilesX = 100;
int tilesY = 100;

PImage img;

float mag;

void setup() {
  size(900, 900, P3D);
  img = loadImage("a.jpg");
  img.resize(tilesX, tilesY);
}

void draw() {

  float mag = mouseX;
  background(#f1f1f1);
  fill(#000000);
  noStroke();

  push();
  translate(width/2, height/2);

  rotateY(radians(frameCount));
  rotateX(radians(frameCount));
  
  for (int x = 0; x < tilesX; x++) {
    for (int y = 0; y < tilesY; y++) {
      
      color c = img.get(x, y);
      float b = brightness(c);
      float s = map(b, 255, 0, 0, (mag * 2) / tilesX);
      
      float posX = map(x,0,tilesX,-mag,mag);
      float posY = map(y,0,tilesY,-mag,mag);
      
      push();
      translate(posX, posY);
      circle(0, 0, s);
      pop();
    }
  }

  pop();
}
