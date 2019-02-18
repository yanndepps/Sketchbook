// Times Tables Cardioid Visualization
// good colors
// color c4 = color(240, 202, 140);
color c1 = #F14A40;
color c2 = #F89F7C;
color c3 = #FEDBB4;
color c4 = #F0CA8C;

float r; 
// float factor = 4;

// a PVector function for any given index
PVector getVector(float index, float total) {
  float angle = map(index % total, 0, total, 0, TWO_PI);
  PVector v = PVector.fromAngle(angle + PI);
  v.mult(r);
  return v;
}

void settings(){
  size(800, 800);
  smooth(8);
  // println("#"+hex(c4, 6));
}

void setup() {
  r = height/4-35;
}

void draw() {
  background(33);
  int total = 200;
  // factor += 0.01;

  // top left geo
  pushMatrix();
  translate(width*0.25, height*0.25);
  noStroke();
  fill(c4);
  rectMode(CENTER);
  rect(0, 0, width/2, height/2);

  for (int i = 0; i < total; i++) {
    PVector v = getVector(i, total);
    noStroke();
    fill(c1);
    circle(v.x, v.y, 4);
  }

  for (int i = 0; i < total; i++) {
    float factor = 51;
    PVector a = getVector(i, total);
    PVector b = getVector(i * factor, total);
    stroke(c1);
    strokeWeight(0.75);
    line(a.x, a.y, b.x, b.y);
  }
  popMatrix();

  // top right geo
  pushMatrix();
  translate(width*0.75, height*0.25);
  noStroke();
  fill(c1);
  rectMode(CENTER);
  rect(0, 0, 400, height/2);

  for (int i = 0; i < total; i++) {
    PVector v = getVector(i, total);
    noStroke();
    fill(c4);
    circle(v.x, v.y, 4);
  }

  for (int i = 0; i < total; i++) {
    float factor = 24;
    PVector a = getVector(i, total);
    PVector b = getVector(i * factor, total);
    stroke(c4);
    strokeWeight(0.75);
    line(a.x, a.y, b.x, b.y);
  }
  popMatrix();

  // bottom left geo
  pushMatrix();
  translate(width*0.25, height*0.75);
  noStroke();
  fill(c2);
  rectMode(CENTER);
  rect(0, 0, 400, 400);

  for (int i = 0; i < total; i++) {
    PVector v = getVector(i, total);
    noStroke();
    fill(c3);
    circle(v.x, v.y, 4);
  }

  for (int i = 0; i < total; i++) {
    float factor = 33;
    PVector a = getVector(i, total);
    PVector b = getVector(i * factor, total);
    stroke(c3);
    strokeWeight(0.75);
    line(a.x, a.y, b.x, b.y);
  }
  popMatrix();

  // bottom right geo
  pushMatrix();
  translate(width*0.75, height*0.75);
  noStroke();
  fill(c3);
  rectMode(CENTER);
  rect(0, 0, 400, 400);

  for (int i = 0; i < total; i++) {
    PVector v = getVector(i, total);
    noStroke();
    fill(c2);
    circle(v.x, v.y, 4);
  }

  for (int i = 0; i < total; i++) {
    float factor = 81;
    PVector a = getVector(i, total);
    PVector b = getVector(i * factor, total);
    stroke(c2);
    strokeWeight(0.75);
    line(a.x, a.y, b.x, b.y);
  }
  popMatrix();
}
