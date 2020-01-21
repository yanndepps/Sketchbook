// Visions of the Bauhaus
// Motion Studies in Space : 02

/*
  Line relationships and their plane-forming effect
  are explored.
*/

Particle p;
ArrayList<Particle> particles;

void setup() {
  size(800, 800);
  background(255);
  smooth();
  particles = new ArrayList<Particle>();
}

void draw() {
  particles.add(new Particle(new PVector(random(width), random(height))));
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i/5);
    p.update();
    p.display();
  }
}

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan = 255;
  float grad = 0;
  Particle(PVector l) {
    acc = new PVector(random(-0.0001, 0.0001), random(-0.0001, 0.0001));
    vel = new PVector(random(-0.04, 0.04), random(-0.04, 0.04));
    loc = l.get();
  }
  void update() {
    vel.add(acc);
    loc.add(vel);
    lifespan -= .15;
  }
  void display() {
    strokeWeight(0.5);
    stroke(0, lifespan);
    pushMatrix();
    translate(loc.x, loc.y);
    grad = grad + .0001;
    rotate(radians(noise(grad)*180));
    line(0, -50, 0, +50);
    popMatrix();
  }
}
