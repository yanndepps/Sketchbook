// kynetic typography
PGraphics pg;
PFont font;

void setup() {
  font = createFont("../data/RobotoMono-Regular.ttf", 600);
  size(800, 800, P2D);
  pg = createGraphics(800, 800, P2D);
  // frameRate(5);

}

void draw() {
  background(0);
  pg.beginDraw();
  pg.background(0);
  pg.fill(255);
  pg.textFont(font);
  pg.textSize(800);
  pg.pushMatrix();
  pg.translate(width/2, height/2-215);
  pg.textAlign(CENTER, CENTER);
  pg.text("a", 0, 0);
  pg.popMatrix();
  pg.endDraw();

  // call our PGraphics element
  // image(pg, 0, 0);
  // wrap a two-dimensional for-loop to create a grid
  // define a number of tiles for both x and y axis
  int tilesX = 8;
  int tilesY = 8;

  int tileW = int(width/tilesX);
  int tileH = int(height/tilesY);

  for (int y = 0; y < tilesY; y++) {
    for (int x = 0; x < tilesX; x++) {
      int wave = int(sin(frameCount * 0.05 + (x * y) * 0.07) * 100);
      //  source
      int sx = x*tileW + wave;
      int sy = y*tileH;
      int sw = tileW;
      int sh = tileH;

      // destination
      int dx = x*tileW;
      int dy = y*tileH;
      int dw = tileW;
      int dh = tileH;

      // copy function
      copy(pg, sx, sy, sw, sh, dx, dy, dw, dh);
    }
  }
}
