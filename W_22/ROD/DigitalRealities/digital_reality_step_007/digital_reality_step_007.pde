float MAGNITUDE = 12000;
PImage tex;

ArrayList<Videowall> walls;

float speed = 10;

float tileW;
float tileH;

float cameraZ = 0;
PShape globe;
color BG = 0;
color FG = #F1F1F1;

float m; 

float TILES_X = 100;
float TILES_Y = 100;

void setup() {
  size(1920, 1080, P3D);
  tex = loadImage("1.jpg");
  tex.filter(GRAY);
  globe = createShape(SPHERE, 5000);
  globe.textureMode(NORMAL);
  globe.setTexture(tex);
  globe.setStroke(false);

  walls = new ArrayList<Videowall>();

  for (int i = 0; i < 10; i++) {
    walls.add(new Videowall(i));
  }

  imageMode(CENTER);

  tileW = MAGNITUDE/TILES_X;
  tileH = MAGNITUDE/TILES_Y;
}

void draw() {
  
  m = map(mouseX, 0, width, -1000, 1000);

  float eyeX = width/2.0 + m;
  float eyeY = height/2.0;
  float eyeZ =(height/2.0) / tan(PI*30.0 / 180.0);
  float centerX = width/2.0;
  float centerY = height/2.0;
  float centerZ = 0;
  float upX = 0;
  float upY = 1;
  float upZ = 0;
  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);

  
  background(BG);
  directionalLight(100, 100, 100, -1, 0, -1);
  perspective(PI/3.0, (float)width/height, 1, 100000);
  scene();
  interactionKeyboard();
}
