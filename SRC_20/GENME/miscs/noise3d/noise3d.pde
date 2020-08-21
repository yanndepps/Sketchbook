// Noise3d Generator
// generateme.tumblr.com

// setup below
// - click to change object
// - move mouse to rotate
// - press space to save (image and obj file)
// - press + to zoom in
// - press - to zoom out

// PARAMETRIZATION
final static float sfactor = 1.0/1000.0; // scaling factor for noise
final static float theta_mul = 15.0; // theta angle multiplication
final static float phi_mul = theta_mul/2.0; // phi angle multiplication

final static boolean symmetry = true; // symmetric object or not
final static float rstep = 5; // step for next polygon
final static float rwidth = 2.5; // ribbon width
final static int noribbons = 200; // number of ribbons
final static int novertices = 1000; // number of vertices in ribbon
final static int shapetype = QUAD_STRIP; // Processing beginShape() value
final static int alpha = 60; // alpha channel for ribbon
// END PARAMETRIZATION

// local variables
PShape[] p;
float sc = 1;

PVector[][] initpoints;
PVector v1shift,v2shift;

void setup() {
  size(1000, 1000, P3D);
  background(20);
  noStroke();
  smooth(8);

  fill(240, alpha);

  initpoints = new PVector[2][noribbons];
  for (int i=0; i<noribbons; i++) {
    PVector v = new PVector(random(-80, 80), random(-80, 80), random(-80, 80));
    initpoints[0][i] = v;
    PVector a = new PVector(random(-TWO_PI, TWO_PI), random(-TWO_PI, TWO_PI));
    initpoints[1][i] = a;
  }
  
  if(symmetry) {
    v1shift = v2shift = new PVector(0,0,0);
  } else {
    v1shift = new PVector(random(-20,20),random(-20,20), random(-20,20));
    v2shift = new PVector(random(-20,20),random(-20,20), random(-20,20));
  }

  createShapes(0);
}

void createShapes(float time) {
  float theta, phi; // spherical angles for step
  float x1, y1, z1; // one side of the ribbon
  float x2, y2, z2; // second side of the ribbon

  float tmul = theta_mul * TWO_PI;
  float pmul = phi_mul * TWO_PI;

  p = new PShape[noribbons];
  for (int s=0; s<noribbons; s++) {
    x1=initpoints[0][s].x+time;
    x2=x1+rwidth;
    y1=initpoints[0][s].y+time;
    y2=y1+rwidth;
    z1=initpoints[0][s].z+time;
    z2=z1+rwidth;

    theta=initpoints[1][s].x;
    phi=initpoints[1][s].y;

    p[s] = createShape();
    p[s].beginShape(shapetype);

    for (int i=0; i<novertices; i++) {

      // spehere coordinates to cartesian
      float ct = cos(theta);
      float cp = cos(phi);
      float st = sin(theta);
      float sp = sin(phi);
      float xstep = rstep*ct*sp;
      float ystep = rstep*st*sp;
      float zstep = rstep*cp;

      // move points
      x1 += xstep;
      y1 += ystep;
      z1 += zstep;
      x2 += xstep;
      y2 += ystep;
      z2 += zstep;

      PVector v1 = new PVector(x1, y1, z1);
      PVector v2 = new PVector(x2, y2, z2);

      v1.mult(sfactor);
      v2.mult(sfactor);
      v1.add(v1shift);
      v2.add(v2shift);

      theta += tmul*map(noise(v1.x, v1.y, v2.z), 0, 1, -1, 1);
      phi += pmul*map(noise(v2.x, v2.y, v2.z), 0, 1, -1, 1);      

      p[s].vertex(x1, y1, z1);
      p[s].vertex(x2, y2, z2);
    }
    p[s].endShape();
  }
}

PVector vexp(PVector p, float weight) {
  float r = weight * exp(p.x);
  return new PVector(r * cos(p.y), r * sin(p.y), r*cos(p.z));
}

PVector waves2(PVector p, float weight) {
  float x = weight * (p.x + 0.9 * sin(p.x * 4));
  float y = weight * (p.y + 0.5 * sin(p.y * 5.555));
  float z = weight * (p.z + 0.9 * sin(p.z * 0.555));
  return new PVector(x, y, z);
}

PVector sinusoidal(PVector p, float weight) {
  float x = weight * sin(p.x);
  float y = weight * sin(p.y);
  float z = weight * sin(p.z);
  return new PVector(x, y, z);
}

PVector cross(PVector p, float weight) {
  float r = sqrt(1.0 / (sq(sq(p.x)-sq(p.y)-sq(p.z)))+1.0e-10);
  return new PVector(weight * 0.8 * p.x * r, weight * 0.8 * p.y * r, weight * 0.8 * p.z * r);
}

final static int frames = 25*30;

void draw() {  
  fill(240, alpha);
  // createShapes(0.01*sin(frameCount*TWO_PI/frames));

  background(20);
  lights();
  ambient(240);
  shininess(1.0);

  camera(width/2, mouseY, 1.3*(height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

  translate(width/2, height/2); 
  scale(sc);
  rotateY(map(mouseX, 0, width, -PI, PI));
  //rotateY(map(frameCount, 0, frames, -PI, PI));
  //rotateX(map(frameCount, 0, frames, 0, 4*TWO_PI));

  for (PShape s : p) {
    shape(s, 0, 0);
  }

  // if(frameCount<=frames) saveFrame("f/f#####.jpg");
}

void mouseClicked() {
  noiseSeed((int)random(MAX_INT));
  createShapes(0);
}

void keyPressed() {
  if (key == '+') sc*=1.1;
  if (key == '-') sc/=1.1;
  if (keyCode == 32) {
    String n = hex( (int)random(0xfffff), 5);
    print("saving image and obj files ("+n+")...");
    save( n + ".jpg");
    saveObj( n + ".obj");
    println("done");
  }
}

void saveObj(String fn) {
  PrintWriter out = createWriter(fn);

  out.println("# Noise3D generator, export by GenerateMe");
  out.println("# https://gist.github.com/tsulej/795526e370a59041dbb11739269d2afd");
  out.println("# http://generateme.tumblr.com");

  int iter = 1;
  for (PShape sh : p) {
    ArrayList<String> faces = new ArrayList<String>(novertices);
    out.println("");
    out.println("# vertices");

    for (int v=0; v<sh.getVertexCount ()-4; v+=2) {
      PVector vec0 = sh.getVertex(v);
      PVector vec1 = sh.getVertex(v+1);
      PVector vec3 = sh.getVertex(v+2);
      PVector vec2 = sh.getVertex(v+3);
      out.println("v " + vec0.x + " " + vec0.y + " " + vec0.z);
      out.println("v " + vec1.x + " " + vec1.y + " " + vec1.z);
      out.println("v " + vec2.x + " " + vec2.y + " " + vec2.z);
      out.println("v " + vec3.x + " " + vec3.y + " " + vec3.z);
      faces.add("f " + (iter++) + " " + (iter++) + " " + (iter++) + " " + (iter++));
    }

    out.println("");
    out.println("# faces");

    for (String s : faces) {
      out.println(s);
    }
  }

  out.flush();
  out.close();
}