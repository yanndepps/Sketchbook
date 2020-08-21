// see: https://github.com/hamoid/Fun-Programming/blob/master/processing/ideas/2016/02/caustic/caustic.pde

void setup() {
  size(600,600);
  smooth(3);
  background(240);
  fill(10,20,30,10);
  noStroke();
  frameRate(600);
}

float scaled = 0.003;
float scale = 0.05;
float d = 10;
float x = -15.0;
boolean active = true;

PVector ex(PVector v) {
  float r = v.mag();
  float theta = v.heading();
  float xsin = sin(theta + r);
  float ycos = cos(theta - r);
  float xx = r * xsin * xsin * xsin;
  float yy = r * ycos * ycos * ycos;
  return new PVector(xx+yy,xx-yy);
}

PVector diamond(PVector v) {
  float r = v.mag();
  float theta = v.heading();
  float xx = 3*sin(theta) * cos(r);
  float yy = 3*cos(theta) * sin(r);
  return new PVector(xx,yy);
}

PVector exponential(PVector v) {
  float r = PI * v.y;
  float d = exp(v.x-1);
  return new PVector(d * cos(r), d*sin(r));
}

PVector sinusoidal(PVector v) {
  return new PVector(sin(v.x),sin(v.y));
}

PVector tilt2(PVector v) {
  v.mult(scale);
  //return diamond(v);
  //return ex(v);
  //return exponential(v);
  //return exponential(diamond(v));
  //return ex(diamond(exponential(v)));
  return sinusoidal(diamond(sinusoidal(v)));
} 

float tilt(float x, float y) {
  return noise(x*scaled, y*scaled);
}

void draw() {
  if(active) {
    for(float y=-15.0;y<height+15.0;y+=0.3) {
      float hx = x - width/2;
      float hy = y - height/2;
      float delta = 4 * tilt(hx,hy);
      PVector t1 = tilt2(new PVector(hx-delta,hy+delta));
      PVector t2 = tilt2(new PVector(hx+delta,hy-delta));
      float dx = d * (t1.x - t2.x);
      float dy = d * (t2.y - t1.y);
      
      rect(x+dx,y+dy,1,1);
    }
    x+=0.3;
    if(x>width+15.0) active = false;
  }
}