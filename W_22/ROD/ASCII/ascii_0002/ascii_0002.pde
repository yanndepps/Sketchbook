PGraphics pg;
PImage img;
PFont font;

String charset = " ▀▐▞▚▖▗▝▙▄█▌▛▜▟";

color BG = #F1f1F1;

void setup() {
 
  size(620, 620, P2D);
  pg = createGraphics(width, height, P3D);
  img = loadImage("a.jpg");
  img.resize(int(width*0.9), 0);
  font = createFont("IBMPlexMono-Regular.otf", 1000);
}

void draw() {
  
   background(BG);    
  pg.beginDraw();
  //pg.background(#F1F1F1);
  pg.directionalLight(255, 255, 255, -1, 0, -1);
  pg.imageMode(CENTER);
  pg.push();
  pg.translate(width/2, height/2);
  pg.rotateY(radians(frameCount));
  pg.rotateX(radians(frameCount));
  pg.image(img, 0, 0);
  pg.pop();
  pg.endDraw();

  float tilesX = 170;
  float tilesY = tilesX * 0.5;

  float tileW = width / tilesX;
  float tileH = height / tilesY;

  PImage buffer = pg.get();



  textFont(font);
  textAlign(CENTER, CENTER);
  textSize(tileH * 0.7);

  fill(#000000);

  for (int x = 0; x < tilesX; x++) {
    for (int y = 0; y < tilesY; y++) {
      int px = int(x * tileW);
      int py = int(y * tileH);

      color c = buffer.get(px, py);
      float b = brightness(c);

      int selector = int(map(b, 0, 255, charset.length()-1, 0));

      char ch = charset.charAt(selector);

      push();
      translate(tileW * x, tileH * y);
      text(ch, 0, 0);
      pop();
    }
  }
}
