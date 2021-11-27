// --- Surfaces --- //
// concept based on vectors' angles
// https://generateme.wordpress.com/
// uncomment line 35 to use a difference of vector field result and input


/* int nw = 1754; */
/* int nh = 1754; */
int nw = 512;
int nh = 512;


void settings() {
  size(nw, nh, P2D);
  smooth(8);
}

void setup() {
  noStroke();
  background(240);
  fill(10, 10);
}

void draw() {
  generate();
}

// draw 10000 points at once
void generate() {
  for (int i = 0; i < 10000; i++) {
    // random input vector
    PVector v = new PVector(random(-1, 1), random(-1, 1));
    // vector field
    PVector fv = popcorn(v);
    // subtract trick
    fv.sub(v);

    float alpha = v.heading();
    float beta = fv.heading();

    float x = map(alpha, -PI, PI, 50, width-50);
    float y = map(beta, -PI, PI, 50, height-50);

    rect(x, y, 1, 1);
  }
}

// popcorn vector field
float popcorn_c = random(-0.8, 0.8);
float popcorn_f = random(-0.8, 0.8);

PVector popcorn(PVector p) {
  float x = p.x + popcorn_c * sin(tan(3.0 * p.y));
  float y = p.y + popcorn_f * sin(tan(3.0 * p.x));
  return new PVector(x, y);
}

// save output
void keyPressed() {
  if (key == 's') saveImage();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
