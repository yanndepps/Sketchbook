// collatz conjecture visualization
// generateme.tumblr.com

void setup() {
  size(1024, 500);
  background(20);
  stroke(220, 100);
  strokeWeight(0.6);
  smooth(8);
}

float ang = 0; // inital angle
float step = TWO_PI/200.0; // angle step
int c0 = 100000; // initial number for sequence

void draw() {
  for (int i=0; i<200; i++) {
    int c = c0;
    int x = (c0-100000);
    int y = 400;
    // if c==4, sequence is cyclic
    // hypothesis says, every collatz sequence ends with cycle 4,2,1,4,...
    while (c!=4) {
      if ((c&1)>0) { // change angle one direction...
        ang+=step;
        c=3*c+1;
      } else { // ... or other
        ang-=step;
        c >>= 1;
      }
      x+=cos(ang);
      y+=sin(ang);
      point(x/5.0, y);
    }
    c0++; // next sequence
  }
}

void keyPressed() {
  saveFrame("res2#####.png");
}