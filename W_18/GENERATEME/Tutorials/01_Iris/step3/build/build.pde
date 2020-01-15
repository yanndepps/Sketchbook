/*
*
* step3 --> Attribue Love Factor
*
* let's introduce another attribute of our particle. it will be nonnegative
* floating point value. call it mooc. rule :
* our particles love each other when they have similar mood. hate otherwise.
* that means that we have to calculate similarity factor between moods to get love
* factor. it should be between (-1, 1). where 1 means 100% love and -1 means 100% hate.
* what can be mood ?
* initial angle
* noise value from current position and time (mood changes while particles moves and times goes on)
* some vector field
* etc..
*
*/
// -------- VARS

// number of particles
final static int N = 500;

// colors
final static color[] cols = { #FF8A00, #FFD200, #749D9D, #FCF5B3, #B39500, #272429 };
// collection of all particles
ArrayList<Particle> particles = new ArrayList<Particle>(N);
//
float time = 0.0;

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
        // mood factor
        love *= p.moodSimilarity(o);
        // not too fast
        love *= 0.5;

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
  time += 0.001;
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

  // mood factor
  float mood;

  void reset() {
    // distribute initial point on the ring, more near the outer edge, distorted
    float angle = random(TWO_PI);
    float r = 5.0*randomGaussian() + (width/2-100)*(1.0-pow(random(1.0), 7.0));
    x = cos(angle)*r;
    y = sin(angle)*r;
    // set random age
    age = (int)random(100, 2000);
    calcMood();
  }

  void draw() {
    stroke(c,50);
    point(x+width/2, y+height/2);
  }

  // update position with externally calculated speed
  // check also age
  void update() {
    if(--age < 0) {
      reset();
      } else {
        x += dx;
        y += dy;
        calcMood();
      }
    }

    Particle(int i) {
      id = i;
      reset();
    }

    // compare moods
    float moodSimilarity(Particle p) {
      return 1.0-abs(p.mood-this.mood);
    }
    // calculate current mood
    private void calcMood() {
      mood = sin(noise(x/10.0, y/10.0, time)*TWO_PI);
    }
  }

  //
  void keyPressed() {
    if(key == 'n') noLoop();
    if(key == 'l') loop();
  }
  // -------- END
