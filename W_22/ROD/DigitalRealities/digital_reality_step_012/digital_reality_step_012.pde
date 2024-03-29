float MAGNITUDE = 12000;
PImage tex, floor;

PGraphics scene;

PShader shade;

ArrayList<Videowall> walls;

float speed = 50;

float tileW;
float tileH;

float cameraZ = 0;
PShape globe;

color BG = 0;
color FG = #F1F1F1;

float mx, my; 

float TILES_X = 100;
float TILES_Y = 100;

void setup() {
  size(1920, 1080, P3D);
  tex = loadImage("1.jpg");
  floor = loadImage("floor.jpg");
  tex.filter(GRAY);
  floor.filter(GRAY);

  globe = createShape(SPHERE, 10000);
  globe.textureMode(NORMAL);
  globe.setTexture(tex);
  globe.setStroke(false);

  scene = createGraphics(width, height, P3D);

  walls = new ArrayList<Videowall>();

  for (int i = 0; i < 10; i++) {
    walls.add(new Videowall(i));
  }

  imageMode(CENTER);

  tileW = MAGNITUDE/TILES_X;
  tileH = MAGNITUDE/TILES_Y;

  shade = loadShader("halftone.glsl");
}

void draw() {
  // shade.set("pixelsPerRow", 1920);

  mx = map(mouseX, 0, width, -90, 90);
  my = map(mouseY, 0, height, -100, -2000);

  float eyeX = width/2.0;
  float eyeY = height/2.0 + my;
  float eyeZ =(height/2.0) / tan(PI*30.0 / 180.0);
  float centerX = width/2.0;
  float centerY = height/2.0;
  float centerZ = 0;
  float upX = 0;
  float upY = 1;
  float upZ = 0;

  scene.beginDraw();
  scene.background(BG);
  scene.camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);

  // directionalLight(255, 255, 255, 0, 1, 1);
  scene.perspective(PI/3.0, (float)width/height, 1, 100000);
  drawScene();
  interactionKeyboard();

  scene.endDraw();

  image(scene, width/2, height/2);
  // filter(shade);
}
