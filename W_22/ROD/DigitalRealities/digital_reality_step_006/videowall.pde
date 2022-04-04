class Videowall {

  PGraphics pg;
  
  float X;
  float Z;
  float ROT; 

  int TILESX = 3;
  int TILESY = 2;

  PShape[] shapes;

  float TILESIZE;
  
  int modulo;

  Videowall() {

    modulo = int(random(5,60));
    
    pg = createGraphics(600, 400);

    noStroke();

    shapes = new PShape[14];

    shapes[0] = loadShape("A.svg");
    shapes[1] = loadShape("B1.svg");
    shapes[2] = loadShape("B2.svg");
    shapes[3] = loadShape("B3.svg");
    shapes[4] = loadShape("B4.svg");
    shapes[5] = loadShape("C.svg");
    shapes[6] = loadShape("D1.svg");
    shapes[7] = loadShape("D2.svg");
    shapes[8] = loadShape("D3.svg");
    shapes[9] = loadShape("D4.svg");
    shapes[10] = loadShape("E1.svg");
    shapes[11] = loadShape("E2.svg");
    shapes[12] = loadShape("E3.svg");
    shapes[13] = loadShape("E4.svg");

    for (int i = 0; i < shapes.length; i++) {
      shapes[i].disableStyle();
    }

    TILESIZE = pg.width / TILESX;
    
    X = random(-1000,1000);
    Z = random(-1000,1000);
    ROT = random(360);
    
    print(ROT);
    
  }

  void display() {
    pg.beginDraw();

    if (frameCount % modulo == 0 || frameCount == 1) {
      pg.background(#000000);
      pg.fill(FG);
      pg.noStroke();

      for (int x = 0; x < TILESX; x++) {
        for (int y = 0; y < TILESY; y++) {
          float posX = TILESIZE * x;
          float posY = TILESIZE * y;

          pg.push();
          pg.translate(posX, posY);

          if (random(1) < 0.5) {
            pg.fill(FG);
            pg.rect(0, 0, TILESIZE, TILESIZE);
            pg.fill(BG);
          } else {
            pg.fill(BG);
            pg.rect(0, 0, TILESIZE, TILESIZE);
            pg.fill(FG);
          }

          int selector = int(random(shapes.length));

          pg.shape(shapes[selector], 0, 0, TILESIZE, TILESIZE);
          pg.pop();
        }
      }
    }
    pg.endDraw();
  }
}
