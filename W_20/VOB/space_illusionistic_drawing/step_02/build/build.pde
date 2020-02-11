// Space-Illusionistic Drawing Algorithms : step_02

float d = 0;
float a = 0;
float speed = 0.01;

void setup() {
  size(800, 800);
}

void draw() {
  background(0);
  strokeWeight(20);
  noFill();
  rectMode(CENTER);

  for (int i = height - 100; i >= 0; i--) {
    d = dist(0, 0, 0, i);
    d = d * 255 / ((height-100));

    a = a + speed;
    if (a > 255 || a < 0) {
      speed *= -1;
    }

    stroke(255 - (d+a), (d-a));
    rect(i*2/6, i*5/6, i/2, i/2);
    rect(width-(i*4/6), height-(i*5.8/6), i/4, i/4);
    rect(i*4.5/6, height-(i*4/6), i/1.5, i/1.5);
    rect(width-(i*4/6), i*2/6, i/3, i/3);
  }
}
