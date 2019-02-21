// Heart Curves step 01

void setup() {
  size(400, 400);
  /* smooth(16); */
}

void draw() {
  background(33);
  // orientate toward the center of the window
  translate(width/2, height/2);
  // loop around all the points of a circle
  noFill();
  stroke(255);
  strokeWeight(1);
  beginShape();
  for (float a = 0; a < TWO_PI; a += 0.01) {
    float r = 10;
    // polar to cartesians
    /* float x = r * cos(a); */
    float x = r * 16 * pow(sin(a), 3);
    float y = -r * (13 * cos(a) - 5*cos(2*a) - 2*cos(3*a) - cos(4*a));
    vertex(x, y);
  }
  endShape();
}
