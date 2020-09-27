void drawPg() {
  pg.beginDraw();
  pg.background(#1c1c1c);
  pg.imageMode(CENTER);
  // display image
  pg.push();
  pg.translate(pg.width/2, pg.height/2);
  float wave1 = map(sin(radians(frameCount)), -1, 1, 3, 1.5);
  pg.scale(wave1);
  pg.image(img, 0, 0);
  pg.pop();
  // define style
  pg.textFont(font);
  pg.textAlign(CENTER, CENTER);
  pg.textSize(800);
  pg.fill(#f1f1f1);
  // display type
  String txt = "LOST";
  float tw = pg.textWidth(txt);
  // float wave2 = map(tan(radians(frameCount)), -1 , 1, -10, 10);
  float wave2 = map(tan(radians(frameCount)), -1 , 1, -100, 100);

  pg.push();
  pg.translate(pg.width/2 + wave2, pg.height/2-60);
  pg.text(txt, 0, 0);
  pg.pop();
  // end draw
  pg.endDraw();
}
