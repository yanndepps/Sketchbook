// Times Tables Cardioid Visualization

int total = 200;
int factor = 85;
float r; 
// a PVector function for any given index
PVector getVector(int index) {
  float angle = map(index % total, 0, total, 0, TWO_PI);
  PVector v = PVector.fromAngle(angle + PI);
  v.mult(r);
  return v;
}

void settings(){
  size(400, 400);
  smooth(3);
}

void setup() {
  r = width/2-35;
}

void draw() {
  background(33);
  translate(width/2, height/2);
  stroke(200);
  noFill();
  circle(0, 0, r*2);

  for (int i = 0; i < total; i++) {
    PVector v = getVector(i);
    fill(255);
    circle(v.x, v.y, 3);
  }

  for (int i = 0; i < total; i++) {
    PVector a = getVector(i);
    PVector b = getVector(i * factor);
    stroke(255);
    strokeWeight(0.75);
    line(a.x, a.y, b.x, b.y);
  }
}
