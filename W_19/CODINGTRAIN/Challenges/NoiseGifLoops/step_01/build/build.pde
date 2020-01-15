// Perlin Noise Gif Loops : part_01

float a = 0;
color c = #70b9c6;

void setup() {
  size(400, 400);
  // println(hex(c));

}

void draw() {
  background(33);
  float noiseMax = 5;
  float xoff = map(cos(a), -1, 1, 0, noiseMax);
  float yoff = map(sin(a), -1, 1, 0, noiseMax);
  float r = noise(xoff, yoff);
  float x = map(r, 0, 1, 0, width);
  fill(c);
  noStroke();
  circle(x, height/2, 50);
  //  println(r);
  a += radians(1);
}
