// Times Tables Cardioid Visualization (animated) 

float r; 
float factor = 0;

// a PVector function for any given index
PVector getVector(float index, float total) {
  float angle = map(index % total, 0, total, 0, TWO_PI);
  PVector v = PVector.fromAngle(angle + PI);
  v.mult(r);
  return v;
}

void settings(){
  size(400, 400);
  smooth(8);
}

void setup() {
  r = width/2-35;
}

void draw() {
  background(33);

  int total = 200; 
  factor += 0.01;

  translate(width/2, height/2);
  /* stroke(241, 90, 34); */
  /* noFill(); */
  /* circle(0, 0, r*2); */

  
  for (int i = 0; i < total; i++) {
    PVector v = getVector(i, total);
    noStroke();
    fill(231, 217, 189);
    circle(v.x, v.y, 4);
  }

  for (int i = 0; i < total; i++) {
    PVector a = getVector(i, total);
    PVector b = getVector(i * factor, total);
    stroke(231, 217, 189);
    strokeWeight(0.75);
    line(a.x, a.y, b.x, b.y);
  }

}
