// Visions of the Bauhaus
// Motion Studies in Space : 03

Particle p;
ArrayList<Particle> particles;
int count = 0;

void setup() {
  size(800, 800, P2D);
  background(0);
  particles = new ArrayList<Particle>();
  smooth(8);
}

void draw() {
  if (count > random(250, 450)) {
    count = 0;
    background(0);
  }

  particles.add(new Particle(new PVector(random(200, width-200), random(200, height-200))));

  for (int i = particles.size()-1; i >= 0; i -= 1) {
    Particle p = particles.get(i/1000);
    p.update();
    p.display();

    if (p.isDead()) {
      particles.remove(i);
      count = count + 1;
    }
  }
}

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan = 0;
  float grad = 0;

  Particle(PVector l) {
    acc = new PVector(random(-0.00001, 0.00001), random(-0.00001, 0.00001));
    vel = new PVector(random(-.02, .02), random(-.02, .02));
    loc = l.get();
  }

  void update() {
    vel.add(acc);
    loc.add(vel);
    acc.limit(.01);
    vel.limit(0.05);
    lifespan += .02;
  }

  boolean isDead() {
    if (loc.x < 200 || loc.y < 200 || loc.x > width-200 || loc.y > height-200) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    grad = grad + .0001;
    strokeWeight(0.5);
    stroke(lifespan);

    pushMatrix();
    translate(loc.x, loc.y);
    float r = noise(grad);
    r = map(r, 0, 1, -90, 90);
    rotate(radians(r));
    line(-100, -100, 100, 100);
    popMatrix();
  }
}
