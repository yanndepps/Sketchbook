float MAGNITUDE = 12000;
PImage tex;

float cameraZ = 0;
PShape globe;
color BG = 0;
color FG = #F1F1F1;

void setup() {
  size(1920, 1080, P3D);
  tex = loadImage("3.jpg");
  tex.filter(GRAY);
  globe = createShape(SPHERE,5000);
  globe.textureMode(NORMAL);
  globe.setTexture(tex);
  globe.setStroke(false);
  
}

void draw() {
  background(BG);

  perspective(PI/3.0, (float)width/height, 1, 100000);

  float tilesX = 100;
  float tilesY = 100;

  float tileW = MAGNITUDE/tilesX;
  float tileH = MAGNITUDE/tilesY;

  fill(#0000FF);
  noStroke();

  push();
  translate(width/2, height/2);
  rotateY(radians(frameCount * 0.01));
  texture(tex);
  shape(globe);
  pop();

  fill(FG);
  noStroke();

  push();
  translate(width/2, height/2 + 200, cameraZ);
  rotateX(radians(90));
  
  rectMode(CENTER);
  push();
  fill(BG);
  translate(0,20);
  rect(0,0,MAGNITUDE,MAGNITUDE);
  pop();

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
