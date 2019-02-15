// Times Tables Cardioid Visualization (animated based on mouse position)

int factor = 2;
float r; 

// a PVector function for any given index
PVector getVector(int index, int total) {
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
  int total = int(map(mouseX, 0, width, 0, 200)); 
  translate(width/2, height/2);
  /* stroke(241, 90, 34); */
  /* noFill(); */
  /* circle(0, 0, r*2); */

  
  for (int i = 0; i < total; i++) {
    PVector v = getVector(i, total);
    noStroke();
    fill(167, 72, 96);
    circle(v.x, v.y, 4);
  }

  for (int i = 0; i < total; i++) {
    PVector a = getVector(i, total);
    PVector b = getVector(i * factor, total);
    stroke(202, 88, 104);
    strokeWeight(0.75);
    line(a.x, a.y, b.x, b.y);
  }

}
