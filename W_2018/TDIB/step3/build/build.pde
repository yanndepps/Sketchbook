color[] goodColors = {#f8f8f0, #ffcc00, #edba00, #e6db74, #cccc99,
                      #a6e22e, #8fbe00, #79afa9, #738c73, #75715e, #407886,
                      #37424A, #00a8c6, #aa6699, #cc0033, #da2000,
                      #f92672, #967efb, #a0a0a0};



void setup() {
  size(800, 800);
  background(#eeeeee);
  noLoop();
}


void draw() {
  background(#313437);
  translate(width/2, height/2);
  for (int n = 0; n < 10; n++) {
    int bglen = goodColors.length;
    int rnd = (int)random(bglen);
    stroke(goodColors[rnd], 100);
    for (int a = 0; a < 360; a+=2) {
      float x = random(50, 150);
      float xx = random(150, 350);
      pushMatrix();
      rotate(radians(a));
      strokeCap(CORNER);
      strokeWeight(2);
      line(x, 0, xx, 0);
      popMatrix();
    }
  }
  saveFrame("frames/####.jpg");
}

void keyPressed() {
  redraw();
}
