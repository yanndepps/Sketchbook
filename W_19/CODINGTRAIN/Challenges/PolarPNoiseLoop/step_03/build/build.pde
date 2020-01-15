// Polar Perlin Noise Loop : step_03

float noiseMax = 0.5;
color c = #70b9c6;
void setup() {
  size(400, 400);
  // println(hex(c));

}

void draw() {
  background(33);
  translate(width/2, height/2);
  noStroke();
  fill(c);
  beginShape();
  for (float a = 0; a<TWO_PI; a+=0.02){
    float xoff = map(cos(a), -1, 1, 0, noiseMax);
    float yoff = map(sin(a), -1, 1, 0, noiseMax);
    float r = map(noise(xoff, yoff), 0, 1, 100, 200);
    float x = r * cos(a);
    float y = r * sin(a);
    vertex(x, y);
  }
  endShape(CLOSE);
  noiseMax += 0.07;
}
