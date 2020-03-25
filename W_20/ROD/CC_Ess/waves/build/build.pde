void setup() {
  size(400, 400);
}

void draw() {
  background(0);
  fill(255);
  noStroke();
  float wave = sin(radians(frameCount));
  // float wave = tan(radians(frameCount));
  ellipse(width/2 + wave * 100, height/2, 200, 200);
}