color[] goodColors = {#f8f8f0, #ffcc00, #edba00, #e6db74, #cccc99,
                      #a6e22e, #8fbe00, #79afa9, #738c73, #75715e, #407886,
                      #37424A, #00a8c6, #aa6699, #cc0033, #da2000,
                      #f92672, #967efb, #a0a0a0};



void setup() {
  size(800, 800);
  background(#eeeeee);
  noLoop();
  // println(goodColors.length);
}


void draw() {
  background(#eeeeee);

  for (int i=-100; i<width+100; i+=200) {
    for (int j=-100; j<height+100; j+=200) {
      noStroke();
      fill(#313437);
      rectMode(CENTER);
      rect(i, j, 200, 200);
      pushMatrix();
      translate(i, j);
      scale(0.28);
      for (int n = 0; n < 30; n++) {
        // int rnd = (int)random(19);
        int bglen = goodColors.length;
        int rnd = (int)random(bglen);
        stroke(goodColors[rnd]);
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
      popMatrix();
    }
  }
  // saveFrame("frames/####.jpg");
}

void keyPressed() {
  redraw();
}
