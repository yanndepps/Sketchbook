// --- Surfaces --- //
// concept based on vectors' angles
// https://generateme.wordpress.com/
// add noise -> add distortion to the angles based on noise function


/* int nw = 1754; */
/* int nh = 1754; */
int nw = 620;
int nh = 620;

float dim = min(nw, nh);
float ns = dim * 0.000202;

void settings() {
  size(nw, nh, P2D);
  smooth(8);
}

void setup() {
  println(ns);
  noStroke();
  background(240);
  fill(10, 50);
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
    PVector fv = popcorn(waves(v));
    // subtract trick
    fv.sub(v);

    float al = v.heading();  // alpha
    float be = fv.heading(); // beta

    float n_alpha = 0.5 * (noise(v.x, fv.y, al)-0.5);
    float n_beta = 0.5 * (noise(fv.x, v.y, be)-0.5);

    float x = map(al + n_alpha, -PI, PI, 50, width-50);
    float y = map(be + n_beta, -PI, PI, 50, height-50);

    /* rect(x, y, 1, 1); */
    ellipse(x, y, ns, ns);
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
  println("done saving !");
}
