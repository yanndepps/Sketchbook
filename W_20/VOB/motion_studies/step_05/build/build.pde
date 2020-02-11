// Visions of the Bauhaus
// Motion Studies in Space : 05

float ta = 0;
float tb = 0;
float t1 = 0;
float t2 = 0;
float t3 = 0;
float t4 = 0;
float t5 = 0;
float t6 = 0;
float t7 = 0;
float t8 = 0;
float t9 = 0;
float t10 = 0;

void setup() {
  size(800, 800, P2D);
  noFill();
  stroke(0);
  strokeCap(SQUARE);
}

void draw() {
  background(255);
  ta = ta + 0.012;
  strokeWeight(noise(ta)*200);

  t1 = t1 + 0.01;
  t2 = t2 + 0.011;
  t3 = t3 + 0.0103;
  t4 = t4 + 0.0106;
  float tox1 = map(noise(t1), 0, 1, 50, width-100);
  float tox2 = map(noise(t3), 0, 1, 0, width+100);
  float toy1 = map(noise(t2), 0, 1, 50, height-100);
  float toy2 = map(noise(t4), 0, 1, 0, height+100);
  line(tox1, toy1, tox2, toy2);

  tb = tb + 0.015;
  strokeWeight(noise(tb)*200);

  t5 = t5 + 0.0105;
  t6 = t6 + 0.0111;
  t7 = t7 + 0.0104;
  t8 = t8 + 0.01061;
  t9 = t9 + 0.0102;
  t10 = t10 + 0.0108;
  float ax1 = map(noise(t10), 0, 1, 0, width);
  float ay1 = map(noise(t8), 0, 1, 0, height);
  float ax2 = map(noise(t7), 0, 1, 0, width);
  float ay2 = map(noise(t6), 0, 1, 0, height);
  float ax3 = map(noise(t9), 0, 1, -PI, TWO_PI);
  float ay3 = map(noise(t5), 0, 1, -PI, TWO_PI);
  arc(ax1, ay1, ax2, ay2, ax3, ay3);
}
