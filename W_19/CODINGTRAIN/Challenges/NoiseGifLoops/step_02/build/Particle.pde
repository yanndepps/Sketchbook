class Particle {
  NoiseLoop xnoise;
  NoiseLoop ynoise;
  NoiseLoop dnoise;
  NoiseLoop rnoise;
  NoiseLoop bnoise;

  Particle() {
    xnoise = new NoiseLoop(0.5, -width, width*2);
    ynoise = new NoiseLoop(0.5, -height, height*2);
    dnoise = new NoiseLoop(7, 10, 120);
    rnoise = new NoiseLoop(7, 100, 255);
    bnoise = new NoiseLoop(7, 100, 255);
  }

  void render(float a) {
    float x = xnoise.value(a);
    float y = ynoise.value(a);
    float d = dnoise.value(a);
    float r = rnoise.value(a);
    float b = bnoise.value(a);
    // color c = #70b9c6;
    fill(r, 50, b);
    noStroke();
    circle(x, y, d);
  }
}
