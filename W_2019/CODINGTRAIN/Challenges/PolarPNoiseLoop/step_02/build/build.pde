// Polar Perlin Noise Loop : step_02

float noiseMax = 0.5;
color c = #70b9c6;
float zoff = 0;

void setup() {
  size(400, 400);
}

void draw() {
  background(33);
  translate(width/2, height/2);
  noStroke();
  fill(c);
  beginShape();
  for (float a = 0; a<TWO_PI; a+=0.03){
    float xoff = map(cos(a), -1, 1, 0, noiseMax);
    float yoff = map(sin(a), -1, 1, 0, noiseMax);
    float r = map(noise(xoff, yoff, zoff), 0, 1, 100, 200);
    float x = r * cos(a);
    float y = r * sin(a);
    vertex(x, y);
  }

  endShape(CLOSE);
  zoff += 0.01;
}
