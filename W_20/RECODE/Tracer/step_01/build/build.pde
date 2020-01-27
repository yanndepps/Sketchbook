// The wrong way to use a signed distance function (sdf) : Part_01
// create a sdf, create some particles, and run the traces 
float emitterX, emitterY, emitterZ;
ArrayList<Tracer> tracers;
SDF sdf;

void setup() {
  size(800, 800, P3D);
  smooth(16);
  noCursor();
  createTracers();
  createSDF();
  trace();
}

void createTracers() {
  tracers = new ArrayList<Tracer>();
  float x, y;
  emitterZ = 500;
  float cutoff = 2*emitterZ;
  int resX = 50;
  emitterX = 600.0;
  int resY = 50;
  emitterY = 600.0;

  for (int i=0; i<resX; i++) {
    x = map(i, 0, resX-1, -emitterX*0.5, emitterX*0.5);
    for (int j=0; j<resY; j++) {
      y = map(j, 0, resY-1, -emitterY*0.5, emitterY*0.5);
      tracers.add(new Tracer(new Point(x, y, emitterZ), new Vector(0, 0, -1), cutoff, 0.1));
    }
  }
}

void createSDF() {
  SphereSDF ssdf = new SphereSDF(120);
  sdf = ssdf;
}

void trace() {
  for (Tracer tracer : tracers) {
    tracer.trace(sdf);
  }
}

void draw() {
  background(15);
  // setup perspective
  translate(width/2, height/2);
  rotateY(0.8*QUARTER_PI);
  translate(0, 0, 200);

  // draw sphere
  fill(0);
  noStroke();
  sphere(119);

  // draw limiting plane
  pushMatrix();
  translate(0, 0, -emitterZ-1.0);
  rect(-emitterX*0.5, -emitterY*0.5, emitterX, emitterY);
  popMatrix();

  // draw tracers
  strokeWeight(2);
  stroke(240);
  for (Tracer tracer : tracers) {
    point(tracer.p.x, tracer.p.y, tracer.p.z);
  }
}

// to setup the tracers, we create an emitter, a regular 600*600 square grid 
// of 50*50 points. this emitter is positioned somewhere 'above' the origin.
// each point defines a Tracer aimed along the negative Z-axis. 
// the sdf here is a single sphere at the origin.
// to show the tracers missing the sphere, we draw a limiting plane
// at the cutoff distance.
