void setup() { 
  /* size(960, 540, P2D); */
  size(540, 540, P2D);
  setupShaders();
}

void draw() {
  background(0);
  runShaders();
}
