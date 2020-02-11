// Space-Illusionistic Drawing Algorithms

float d = 0;
float a = 0;
float speed = 2.2;

float t1 = 0;
float t2 = 0;
float t3 = 0;
float t4 = 0;
float t5 = 0;
float t6 = 0;

void setup() {
  size(800, 800);
  noFill();
  rectMode(CENTER);
}

void draw() {
  background(255);
  strokeWeight(10);

  t1 = t1 + 0.017;
  t2 = t2 + 0.018;
  t3 = t3 + 0.019;
  t4 = t4 + 0.02;
  t5 = t5 + 0.021;
  t6 = t6 + 0.022;

  float ta = noise(t1);
  float tb = noise(t2);
  float tc = noise(t3);
  float td = noise(t4);
  float te = noise(t5);
  float tf = noise(t6);

  for (int i = height - 100; i >= 0; i -= 3) {
    d = dist(0, 0, 0, i);
    d = d * 255 / ((height-100));

    a = a + speed;
    if (a > 255 || a < 0) {
      speed *= -1;
    }

    stroke(255 - (d-a), d-a);
    rect(i*ta, i*tb, i/2, i/2);
    rect(width-(i*tc), height-(i*td), i/4, i/4);
    rect(i*te, height-(i*tf), i/1.5, i/1.5);
    rect(width-(i*tb), i*ta, i/2.5, i/2.5);
  }
}
