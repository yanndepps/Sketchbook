// visions of the bauhaus
// movement - countermovement

/*
  This experiment combines the concepts of Klee,
  Mondrian, van Doesburg and Kandinsky and investigates
  multiple position and size relationships between two
  forms in an interactive, relational way.
  A point that can grow into an area the size of
  the entire format is constantly opposed to an area that
  dynamically divides the format to varying degrees in
  response to the movement of the point.
  The parameters of the two forms are controlled either
  by hand or by the so called Perlin Noise; they never
  touch or overlap.
 */

import ddf.minim.*;

Minim minim;
AudioInput in;

PVector loc;
PVector vel;
PVector acc;

float topspeed = 5;
float l = 0;
float l2 = 0;
float r = 0;
float r2 = 0;
float x, y, x2, y2, x3, y3;
float t1 = 0;
float t2 = 0;

void setup() {
  //fullScreen();
  size(400, 400);
  smooth();
  loc = new PVector(mouseX, mouseY);
  vel = new PVector(0, 0);

  minim = new Minim(this);
  in = minim.getLineIn();

  strokeCap(SQUARE);
  fill(0);
  ellipseMode(CENTER);
}

void draw() {
  background(255);

  t1 = t1 + 0.003;
  t2 = t2 + 0.0058;

  float tx = map(noise(t1), 0, 1, 0, width);
  float ty = map(noise(t2), 0, 1, 0, height);

  PVector mouse = new PVector(tx, ty);
  PVector acc = PVector.sub(mouse, loc);
  PVector center = new PVector(width/2, height/2);

  mouse.sub(center);

  acc.normalize();
  acc.mult(.5);
  vel.add(acc);
  vel.limit(topspeed);
  loc.add(vel);

  for (int i = 0; i < in.bufferSize()-1; i++) {
    if (i < in.bufferSize()/2) {
      l = in.left.get(i)*5;
      r = in.right.get(i)*5;
    } else {
      l2 = in.left.get(i+1)*5;
      r2 = in.right.get(i+1)*5;
    }
  }

  x = lerp(x, -(l*width), 0.001);
  y = lerp(y, -(l*height), 0.001);

  translate(width/2, height/2);
  stroke(0);
  strokeWeight(2*width);
  line(x-mouse.x, y-mouse.y, -width/1.9*mouse.x, -height/1.9*mouse.y);
  noStroke();

  x2 = lerp(x2, r*mouse.x*2, 0.05);
  y2 = lerp(y2, r*mouse.y*2, 0.08);
  x3 = lerp(x3, r2*mouse.x*2, 0.05);
  y3 = lerp(y3, r2*mouse.y*2, 0.08);

  float d = map(dist(mouse.x, mouse.y, 0, 0), 0, width/2, 1, 0.7);
  ellipse(x3*d, y3*d, dist(mouse.x, mouse.y, 0, 0)*d, 
                      dist(mouse.x, mouse.y, 0, 0)*d);
}
