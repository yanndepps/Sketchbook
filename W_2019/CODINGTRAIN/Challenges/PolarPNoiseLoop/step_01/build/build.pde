// Polar Perlin Noise Loop : step_01

float noiseMax = 0.5;
float xphase = 0;
float yphase = 0;
color c = #70b9c6;
void setup() {
  size(400, 400);
  // println(hex(c));

}

void draw() {
  background(33);
  translate(width/2, height/2);
  // stroke(255);
  noStroke();
  fill(c);
  //  noFill();
  beginShape();
  for (float a = 0; a<TWO_PI; a+=0.02){
    float xoff = map(cos(a + xphase), -1, 1, 0, noiseMax);
    float yoff = map(sin(a + yphase), -1, 1, 0, noiseMax);
    float r = map(noise(xoff, yoff), 0, 1, 100, 200);
    float x = r * cos(a);
    float y = r * sin(a);
    vertex(x, y);
    // noiseMax += 0.001;
  }

  endShape(CLOSE);
  // noLoop();
  xphase += 0.02;
  yphase += 0.005;
}
