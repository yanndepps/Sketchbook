// Visions of the Bauhaus
// Motion Studies in Space : 06

Murmel m;

void setup() {
  size(600, 600, P2D);
  m = new Murmel();
  background(255);
}

void draw() {
  stroke(0);
  strokeWeight(2);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  m.update();
  m.edges();
  m.display();
}

class Murmel {
  PVector loc;
  PVector vel;
  PVector acc;
  PVector center;
  float r = 10;

  Murmel() {
    loc = new PVector(width/2, height/2);
    center = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void update() {
    PVector mouse = new PVector(mouseX, mouseY);
    mouse.sub(center);
    mouse.setMag(0.02);
    acc = mouse;
    loc.add(vel);
    vel.add(acc);
    vel.limit(5);
  }

  void edges() {
    if (loc.x > width-r) { vel.x = vel.x*(-0.6); loc.x = width-r; }
    if (loc.x < r) { vel.x = vel.x*(-0.6); loc.x = r; }
    if (loc.y > height-r) { vel.y = vel.y*(-0.6); loc.y = height-r; }
    if (loc.y < r) { vel.y = vel.y*(-0.6); loc.y = r; }
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(0);
    noStroke();
    ellipseMode(CENTER);
    ellipse(loc.x, loc.y, r*2, r*2);
  }
}
