/*
 * dynamic waveforms with for-loops
 */

void setup() {
  size(640, 640);
  noStroke();
  fill(#f4f4f4);
}

void draw () {
  background(0);
  float els = 100;
  float elw = width/els;
  float step = 360/els;
  // ---
  push();
  // translate(elw/2, height/2); // y-axis
  translate(width/2, elw/2); // x-axis
  // float mag = height*0.0125; // y-axis
  float mag = width*0.0125; // x-axis
  // println("mag -> ", mag);
  float s = 5;
  for (int i = 0; i < els; i++) {
    push();
    float wave;
    // sine wave on the y axis
    // wave = map(sin(radians(frameCount * 4 + i * step)), -1, 1, -mag, mag);
    // tan waves on the y axis
    wave = map(tan(radians(frameCount * 2 + i * step)), -1, 1, -mag, mag);
    translate(wave,i*elw);
    ellipse(0, 0, s, s);
    pop();
  }
  pop();
}
