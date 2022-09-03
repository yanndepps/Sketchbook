PGraphics pg;
PImage img;

void setup() {
  size(900, 900, P2D);
  pg = createGraphics(width, height, P3D);
  img = loadImage("a.jpg");
  img.resize(int(width*0.9), 0);
}

void draw() {
  pg.beginDraw();
  pg.background(#ffffff);
  pg.directionalLight(255,255,255,-1,0,-1);
  pg.imageMode(CENTER);
  pg.push();
  pg.translate(width/2, height/2);
  pg.rotateY(radians(frameCount));
  pg.rotateX(radians(frameCount));
  pg.image(img,0,0);
  pg.pop();
  pg.endDraw();
  
  image(pg,0,0);
}
