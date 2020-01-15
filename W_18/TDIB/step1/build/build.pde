



void setup() {
  size(800, 800);
  background(#eeeeee);
  //noLoop();
}


void draw() {
  background(#eeeeee);
  translate(width/2, height/2);
  for (int a = 0; a < 360; a+=2) {
    pushMatrix();
    rotate(radians(a));
    line(100, 0, 350, 0);
    popMatrix();
  }
}

void keyPressed() {
  redraw();
}
