/*
 * 2-07
 * step_01
 */

Diagonals da, db;
int nw = 100;
int nh = 100;

void settings() {
  size(nw, nh);
}

void setup() {
  surface.setLocation(25, 25);
  da = new Diagonals(0, nw*0.8, 1, 2, 0);
  db = new Diagonals(0, nw*0.55, 1, 6, 0);
}

void draw() {
  background(204);
  da.update();
  db.update();
}

class Diagonals {
  float x, y;
  int speed, thick, gray;

  Diagonals(float xpos, float ypos, int s, int t, int g) {
    x = xpos;
    y = ypos;
    speed = s;
    thick = t;
    gray = g;
  }

  void update() {
    strokeWeight(thick);
    stroke(gray);
    line(x, y, x+20, y-40);
    line(x+10, y, x+30, y-40);
    line(x+20, y, x+40, y-40);
    x = x + speed;
    if ( x > nw ) {
      x = -nw;
    }
  }
}
