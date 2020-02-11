// Visions of the Bauhaus
// Motion Studies in Space : 01

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
  Particle(PVector l) {
    acc = new PVector(random(-0.001, 0.001), random(-0.001, 0.001));
    vel = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));
    loc = l.get();
  }
  void update() {
    vel.add(acc);
    loc.add(vel);
  }
  void display() {
    strokeWeight(0.5);
    stroke(0, 10);
    line(loc.x+2000*vel.x, loc.y+2000*vel.y,
          loc.x-2000*vel.x, loc.y-2000*vel.y);
  }
}
