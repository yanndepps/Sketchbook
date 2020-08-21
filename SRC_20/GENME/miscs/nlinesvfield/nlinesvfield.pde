// generateme.tumblr.com, 2016
// idea by zach lieberman

// choose variant
int variant = 0; // 0 or 1;

void setup() {
  size(800, 800);
  background(0, 5, 25);
  strokeWeight(0.8);
  smooth(8);
}

color[] pal = {  
  color(0, 91, 197), 
  color(0, 180, 252), 
  color(23, 249, 255), 
  color(223, 147, 0), 
  color(248, 190, 0)
};

class Line { PVector a, b;}
ArrayList<Line> lines = new ArrayList<Line>();

void draw() {
  for (int i=0; i<1000; i++) {
    drawLine();
  }
}

// http://jeffe.cs.illinois.edu/teaching/373/notes/x06-sweepline.pdf
// http://jeffe.cs.illinois.edu/teaching/373/notes/x05-convexhull.pdf
boolean segmentIntersect(PVector a, PVector b, PVector c, PVector d) { 
  return (CCW(a, c, d)!=CCW(b, c, d)) && (CCW(a, b, c) != CCW(a, b, d));
}

boolean CCW(PVector a, PVector b, PVector c) {
  return (c.y-a.y)*(b.x-a.x) > (b.y-a.y)*(c.x-a.x);
}

void drawLine() {
  float x0 = random(width);
  float y0 = random(height);

  float xx = map(x0, 0, width, -3, 3);
  float yy = map(y0, 0, height, -3, 3);

  PVector res = variant==0?variant1(new PVector(xx, yy)):variant2(new PVector(xx, yy));

  Line l = new Line();
  l.a = new PVector(x0, y0);
  l.b = new PVector(x0+res.x, y0+res.y);

  if (lines.size() > 0) {
    for (Line ol : lines) {
      if (segmentIntersect(ol.a, ol.b, l.a, l.b)) return;
    }
  }

  // select color base on vector length
  float len = PVector.dist(l.a, l.b);
  int idx = (int)map(len, 0, 21, 0, pal.length-1);
  stroke(pal[idx], 150);

  line(l.a.x, l.a.y, l.b.x, l.b.y);
  lines.add(l);
}

PVector variant2(PVector in) {
  PVector w = power(in, 1);
  w.normalize();

  float n1 = 3*map(noise(w.x, w.y), 0, 1, -1, 1);
  float n2 = 3*map(noise(w.y, w.x), 0, 1, -1, 1);

  PVector v1 = waves2(new PVector(n1, n2), 1);
  PVector v = PVector.sub(v1, in);

  float ang1 = atan2(v.y, v.x);
  float ang2 = atan2(w.y, w.x);

  v.normalize();
  float n = v.magSq();
  v.mult(TWO_PI);

  float x1 = 16*n*cos(v.x*ang1);
  float y1 = 16*n*sin(v.y-ang2);

  return new PVector(x1, y1);
}

PVector variant1(PVector in) {
  PVector w = waves2(in, 1);
  w.normalize();

  float n1 = 3*map(noise(w.x, w.y), 0, 1, -1, 1);
  float n2 = 3*map(noise(w.y, w.x), 0, 1, -1, 1);

  PVector v = swirl(vexp(new PVector(n1, n2), 1), 1);

  v.normalize();
  float n = v.magSq();
  v.mult(TWO_PI);

  float x1 = 16*n*cos(v.x);
  float y1 = 16*n*sin(v.y);

  return new PVector(x1, y1);
}

PVector vexp(PVector p, float weight) {
  float r = weight * exp(p.x);
  return new PVector(r * cos(p.y), r * sin(p.y));
}

PVector swirl(PVector p, float weight) {
  float r2 = sq(p.x)+sq(p.y);
  float sinr = sin(r2);
  float cosr = cos(r2);      
  float newX = 0.8 * (sinr * p.x - cosr * p.y);
  float newY = 0.8 * (cosr * p.y + sinr * p.y); 
  return new PVector(weight * newX, weight * newY);
}

PVector waves2(PVector p, float weight) {
  float x = weight * (p.x + 0.9 * sin(p.y * 4));
  float y = weight * (p.y + 0.5 * sin(p.x * 5.555));
  return new PVector(x, y);
}

PVector power(PVector p, float weight) {
  float theta = atan2(p.y, p.x);
  float sinr = sin(theta);
  float cosr = cos(theta);
  float pow = weight * pow(p.mag(), sinr);
  return new PVector(pow * cosr, pow * sinr);
}

void keyPressed() {
  saveFrame("####.jpg");
}