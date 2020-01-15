/*
*
* step2 --> BEHAVIOUR
*
* for every particle pair: if they love each other attract, reppel otherwise !
*
* 1. if distance is larger than 2.0 attract with love amount
* 2. repel otherwise
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
  smooth(8);
  strokeWeight(0.7);
  background(0, 0, 20);

  // init particles
  for(int i=0; i<N; i++) {
    particles.add( new Particle(i) );
  }
}

// -------- DRAW

void draw() {
  for(Particle p : particles) {
    // love/hate vector
    float lovex = 0.0;
    float lovey = 0.0;

    for(Particle o : particles) {
      // do not compare with yourself
      if(p.id != o.id) {
        // calculate vector to get distance and direction
        PVector v = new PVector(o.x-p.x, o.y-p.y);
        float distance = v.mag();
        float angle = v.heading();

        // love !
        float love = 1.0 / distance;
        // or hate...
        if (distance<2.0) love = -love;
        // not too fast
        love *= 0.3;

        // update love vector
        lovey += love * sin(angle);
        lovex += love * cos(angle);
      }

      // calculated love vector will be our speed in resultant direction
      p.dx = lovex;
      p.dy = lovey;
    }
  }

  // update and draw
  for(Particle p : particles) {
    p.update();
    p.draw();
  }
}

// -------- FUNCTIONS

class Particle {
  // position
  float x, y;
  // velocity
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
    stroke(c,50);
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

//
void keyPressed() {
  if(key == 'n') noLoop();
  if(key == 'l') loop();
}
// -------- END