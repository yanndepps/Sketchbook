float MAGNITUDE = 12000;
PImage tex;

float speed = 10;

float tileW;
float tileH;

float cameraZ = 0;
PShape globe;
color BG = 0;
color FG = #F1F1F1;

float TILES_X = 100;
float TILES_Y = 100;

void setup() {
  size(1920, 1080, P3D);
  tex = loadImage("3.jpg");
  tex.filter(GRAY);
  globe = createShape(SPHERE, 5000);
  globe.textureMode(NORMAL);
  globe.setTexture(tex);
  globe.setStroke(false);

  tileW = MAGNITUDE/TILES_X;
  tileH = MAGNITUDE/TILES_Y;
}

void draw() {
  background(BG);
  directionalLight(255, 255, 255, -1, 0, -1);
  perspective(PI/3.0, (float)width/height, 1, 100000);
  scene();
  interactionKeyboard();
}
