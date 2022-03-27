/*
 * 2-08
 * step_02
 * an array stores a list of data elements as a single name.
 * a for loop can be used to cycle through each array element in sequence.
 */

int nw = 100;
int nh = 100;
// ---
int num = 20;
int[] dx = new int[num];
int[] dy = new int[num];

void settings() {
  size(nw, nh);
}

void setup() {
  surface.setLocation(25, 25);
  // ---
  for (int i = 0; i < num; i++) {
    dx[i] = i * 5;
    dy[i] = 12 + (i * 6);
  }
}

void draw() {
  background(204);
  // ---
  for (int i = 0; i < num; i++) {
    dx[i] = dx[i] + 1;
    if ( dx[i] > nw ) {
      dx[i] = - nw;
    }
    diagonals(dx[i], dy[i]);
  }
}

void diagonals(int x, int y) {
  line(x, y, x+20, y-40);
  line(x+10, y, x+30, y-40);
  line(x+20, y, x+40, y-40);
}
