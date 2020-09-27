PGraphics pg;
PGraphics pg2;
PGraphics buffer;
PImage img;
PImage img2;
PFont font;


void setup() {
  size(800, 800);
  pg = createGraphics(486, 710);
  pg2 = createGraphics(486, 710);
  buffer = createGraphics(486, 710);

  img = loadImage("a.jpg");
  img2 = loadImage("n.jpg");
  font = createFont("sans.otf", 1000);
}

void draw() {
  background(#1c1c1c);
  // start drawing
  drawPg();
  drawPg2();
  // buffer and transition
  buffer.beginDraw();
  buffer.background(#1c1c1c);
  buffer.noStroke();
  buffer.rectMode(CORNER);
  // grab the pixel element put them on an image
  PImage i1 = pg.get();
  PImage i2 = pg2.get();
  // rasterize the whole thing
  int scalar = 4;
  float tilesX = pg.width/scalar;
  float tilesY = pg.height/scalar;
  float tileW = pg.width/tilesX;
  float tileH = pg.height/tilesY;

  // loop through our pixels
  for (int x = 0; x < tilesX; x++) {
    for (int y = 0; y < tilesY; y++) {
      color c1 = i1.get(int(x * tileW), int(y * tileH));
      color c2 = i2.get(int(x * tileW), int(y * tileH));
      float wave = map(sin(radians(frameCount * 3 + x * 0.3 + y * 0.3)), -1, 1, 0, 1);
      color c3 = lerpColor(c1,c2,wave);
      float bri = brightness(c3);
      float sizeW = map(bri, 0, 255, tileW, 0);
      float sizeH = map(bri, 0, 255, tileH, 0);

      buffer.fill(#305dbf);
      buffer.rect(x * tileW, y * tileW, sizeW * 1.2, sizeH * 1.2);
    }
  }

  buffer.endDraw();
  // render
  imageMode(CENTER);
  image(buffer, width/2, height/2);
  // record movie
  // rec();
  if (frameCount == 720) {
    exit();
  }
}
