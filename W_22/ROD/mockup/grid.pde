PGraphics displayGrid(){
  PGraphics pg = createGraphics(WIDTH,HEIGHT);
  pg.beginDraw();
  pg.clear();
  pg.rectMode(CENTER);
  pg.fill(#ff00ff);
  pg.noStroke();
  float gridThickness = 1;
  pg.rect(width/2,height/2,gridThickness,height);
  pg.rect(width/4,height/2,gridThickness,height);
  pg.rect(width/4*3,height/2,gridThickness,height);
  pg.rect(width/2,height/2,width,gridThickness);
  pg.endDraw();
  return pg;
}
