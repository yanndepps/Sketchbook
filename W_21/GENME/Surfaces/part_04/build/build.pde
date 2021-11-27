// --- Surfaces --- //
// concept based on vectors' angles
// https://generateme.wordpress.com/
// add noise -> add distortion to the angles based on noise function


/* int nw = 1754; */
/* int nh = 1754; */
int nw = 620;
int nh = 620;

int seed = 6;


void settings() {
  size(nw, nh, P2D);
  smooth(8);
}

void setup() {
  randomSeed(seed);
  noStroke();
  background(240);
  fill(10, 10);
}

void draw() {
  generate();
}

// draw x points at once
void generate() {
  for (int i = 0; i < 50000; i++) {
    // random input vector
    PVector v = new PVector(random(-1, 1), random(-1, 1));
    // vector field
    PVector fv = waves(popcorn(v));
    // subtract trick
    fv.sub(v);

    float alpha = v.heading();
    float beta = fv.heading();

    float n_alpha = 0.5 * (noise(v.x, fv.y, alpha)-0.5);
    float n_beta = 0.5 * (noise(fv.x, v.y, beta)-0.5);

    float x = map(alpha + n_alpha, -PI, PI, 50, width-50);
    float y = map(beta + n_beta, -PI, PI, 50, height-50);

    /* rect(x, y, 1, 1); */
    ellipse(x, y, 0.5, 0.5);
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

// waves vector field
float waves_b = random(-0.8, 0.8);
float waves_e = random(-0.8, 0.8);
float waves_c = random(-0.8, 0.8);
float waves_f = random(-0.8, 0.8);

PVector waves(PVector p) {
  float x = p.x + waves_b * sin(p.y * (1.0 / (waves_c * waves_c)));
  float y = p.y + waves_e * sin(p.x * (1.0 / (waves_f * waves_f)));
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
