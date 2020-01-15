// Heart Curves step 02 : animation : 8.19

ArrayList<PVector> heart = new ArrayList<PVector>();
float a;

void setup() {
  size(400, 400, P3D);
  smooth(8);
}

void draw() {
  background(33);
  translate(width/2, height/2);
  noFill();
  stroke(255);
  strokeWeight(4);
  beginShape();
  for (PVector v : heart) {
    vertex(v.x, v.y);
  }
  endShape();

  float r = 10;
  float x = r * 16 * pow(sin(a), 3);
  float y = -r * (13 * cos(a) - 5*cos(2*a) - 2*cos(3*a) - cos(4*a));
  heart.add(new PVector(x, y));
  a += 0.01;
  if (heart.size() > 300) {
    heart.remove(0);
  }
}
