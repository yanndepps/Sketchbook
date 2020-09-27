void drawPg2() {
  pg2.beginDraw();
  pg2.background(#1c1c1c);
  pg2.imageMode(CENTER);
  // display image
  pg2.push();
  pg2.translate(pg2.width/2, pg2.height/2);
  float wave1 = map(sin(radians(frameCount)), -1, 1, 1.3, 2.4);
  pg2.scale(wave1);
  pg2.image(img2, 0, 0);
  pg2.pop();
  // define style
  pg2.textFont(font);
  pg2.textAlign(CENTER, CENTER);
  pg2.textSize(800);
  pg2.fill(#1c1c1c);
  // display type
  String txt = "WORLD";
  float tw = pg2.textWidth(txt);
  // float wave2 = map(tan(radians(frameCount)), -1 , 1, -10, 10);
  float wave2 = map(tan(radians(frameCount)), -1 , 1, -100, 100);

  pg2.push();
  pg2.translate(pg2.width/2 - wave2, pg2.height/2-60);
  pg2.text(txt, 0, 0);
  pg2.pop();
  // end draw
  pg2.endDraw();
}
