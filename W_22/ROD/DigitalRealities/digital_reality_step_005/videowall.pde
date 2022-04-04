class Videowall {

  PGraphics pg;

  int TILESX = 2;
  int TILESY = TILESX;

  PShape[] shapes;

  Videowall() {
    
    pg = createGraphics(800, 600);
    
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
  }

  void generate() {
    pg.beginDraw();
    pg.
    
    pg.endDraw();
    
  }

  void display() {
  }
}
