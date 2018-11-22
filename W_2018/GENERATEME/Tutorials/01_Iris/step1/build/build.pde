/*
*
* step1 --> PARTICLES
*
* we need :
* current position
* current velocity
* age - die sometimes
* color
* id - to distinguish them
*
*/
// -------- VARS

// number of particles
final static int N = 500;

// colors
final static color[] cols = { #FF8A00, #FFD200, #749D9D, #FCF5B3, #B39500, #272429 };

// collection of all particles
ArrayList<Particle> particles = new ArrayList<Particle>(N);

// -------- SETUP

void setup() {
  size(800, 800);
  noFill();
  smooth();
  strokeWeight(2.0);
  background(0, 0, 20);

  // init particles
  for(int i=0; i<N; i++) {
    particles.add( new Particle(i) );
  }
}

// -------- DRAW

void draw() {
  for(Particle p : particles) {
    p.draw();
  }
}

// -------- FUNCTIONS

class Particle {
  // position
  float x, y;
  // steps
  float dx, dy;
  // id
  int id;
  // life length
  float age;
  // some random color
  color c = cols[(int)random(cols.length)];

  void reset() {
    // distribute initial point on the ring, more near the outer edge, distorted
    float angle = random(TWO_PI);
    float r = 5.0*randomGaussian() + (width/2-100)*(1.0-pow(random(1.0), 7.0));
    x = cos(angle)*r;
    y = sin(angle)*r;

    // set random age
    age = (int)random(100, 1000);
  }

  void draw() {
    stroke(c);
    point(x+width/2, y+height/2);
  }

  // update position with externally calculated speed
  // check also age
  void update() {
    x += dx;
    y += dy;
    if(--age < 0) reset();
  }

  Particle(int i) {
    id = i;
    reset();
  }
}
