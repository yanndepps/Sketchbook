// step_02
// area of circle : PI * r^2

int num[] = {3,8,14,45,3,88,56,90,13,15,41,53,77,86,49,33};

void settings() {
  size(800, 300);
}

void setup() {
}

void draw() {
  background(#333333);
  stroke(#f7e1c1);
  fill(#d95f59);

  for(int i = 0; i < num.length; i++) {
    float result = calcArea(num[i]);
    float cw = width / num.length;
    float cs = result / 100.0;
    ellipse(cw*i, height/2, cs, cs);
  }
}

float calcArea(int value) {
  int r = value;
  float area = PI * (r*r);
  return area;
}
