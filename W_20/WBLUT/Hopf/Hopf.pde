//https://csunix1.lvc.edu/~lyons/pubs/hopf_paper_preprint.pdf
ArrayList<HopfFiber> fibers;

void setup() {
  fullScreen(P3D);
  smooth(8);
  fibers=new ArrayList<HopfFiber>();
  //randomFibers(256);
  //randomFibersRings(256);
  FibonnaciFibers(64);
  //FibersRings(4,64);
  //FibersStar(7,64);
}

void randomFibers(int n) {
  for (int i=0; i<n; i++) {
    Point p=randomPointOnUnitSphere(random(1.0));
    fibers.add(new HopfFiber(p, color((p.x+1.0)*128, (p.y+1.0)*128, (p.z+1.0)*128, 200)));
  }
}

void randomFibersRings(int n) {
  for (int i=0; i<n; i++) {
    Point p=randomPointOnUnitSphere(0.1*(int)random(1.0, 10.0));
    fibers.add(new HopfFiber(p, color((p.x+1.0)*128, (p.y+1.0)*128, (p.z+1.0)*128, 200)));
  }
}

Point randomPointOnUnitSphere(float eps) {
  float z = 1.0 - 2.0 * eps;
  float r = sqrt(1.0 - z * z);
  float t = TWO_PI * random(1.0);
  return new Point(r * cos(t), r *sin(t), z);
}

void FibonnaciFibers(int n) {
  float theta;
  float phi;
  for (int i=0; i<n; i++) {
    theta=acos(1 - 2 * (i + 0.5) / n);
    phi=PI * (1.0 + sqrt(5.0)) * (i + 0.5);
    Point p= new Point(cos(phi)*sin(theta), sin(phi)*sin(theta), cos(theta));
    fibers.add(new HopfFiber(p, color((p.x+1.0)*128, (p.y+1.0)*128, (p.z+1.0)*128, 200)));
  }
}

void FibersRings(int n, int m) {
  float theta;
  float phi;
  for (int i=0; i<2*n; i++) {
   
    theta=-PI+PI/n*i+HALF_PI/n;
    for (int j=0; j<m; j++) {
       phi=j*PI/m;
      Point p= new Point(cos(phi)*sin(theta), sin(phi)*sin(theta), cos(theta));
      fibers.add(new HopfFiber(p, color((p.x+1.0)*128, (p.y+1.0)*128, (p.z+1.0)*128, 200)));
    }
  }
}

void FibersStar(int n, int m) {
  float theta;
  float phi;
  for (int i=0; i<n; i++) {
     phi=i*PI/n;
    
    for (int j=0; j<m; j++) {
     theta=-PI+TWO_PI/m*j+PI/m;
      Point p= new Point(cos(phi)*sin(theta), sin(phi)*sin(theta), cos(theta));
      fibers.add(new HopfFiber(p, color((p.x+1.0)*128, (p.y+1.0)*128, (p.z+1.0)*128, 200)));
    }
  }
}

void draw() {
  background(25);
  translate(width/2, height/2);
  scale(80.0);
  ortho();
  drawS2();
  perspective();
  drawHopfFibers();
}

void drawS2() {
  strokeWeight(0.02);
  pushMatrix();
  translate(-10, -4.6);
  rotateY(map(mouseX, 0, width, -PI, PI));
  rotateX(map(mouseY, 0, height, PI, -PI));
  fill(0);
  noStroke();
  sphere(0.99);
  for (HopfFiber fiber : fibers) {
    fiber.drawPoint(1.0, 200);
  }
  popMatrix();
}

void drawHopfFibers() {
  strokeWeight(0.0125);
  rotateY(map(mouseX, 0, width, -PI, PI));
  rotateX(map(mouseY, 0, height, PI, -PI));
  stroke(250, 100);
  noFill();
  for (HopfFiber fiber : fibers) {
    fiber.draw(1024);
  }
}




class HopfFiber {
  Point PS2;
  Quaternion r1;
  Quaternion r2;
  color c;
  HopfFiber(Point pointOnS2, color c) {
    PS2=pointOnS2; 
    if (PS2.x==-1 && PS2.y==0 && PS2.z==0) {
      r1=r2=Quaternion.K;
    } else {
      r1=new Quaternion(0.0, 1+PS2.x, PS2.y, PS2.z).mulSelf(1/sqrt(2.0*(1+PS2.x)));
      r2=new Quaternion(1.0, 0.0, -PS2.z/(1+PS2.x), PS2.y/(1+PS2.x)).mulSelf(sqrt((1+PS2.x)*0.5));
    }
    this.c=c;
  }

  void drawPoint(float scale, float alpha) {
    stroke(red(c), green(c), blue(c), alpha);
    point(scale*PS2.x, scale*PS2.y, scale*PS2.z);
  }

  void draw(int num) {
    float da=TWO_PI/num;
    float a;
    Quaternion Q;
    Point P;
    float d2;
    beginShape();
    for (int i=0; i<=num; i++) {
      a=i*da;
      Q=new Quaternion(cos(a), sin(a), 0.0, 0.0);
      Q.mulLeftSelf(r1);
      P=Q.project();
      d2=(P.y*P.y+P.z*P.z);
      if ((P.y*P.y+P.z*P.z)<9.00) {
        stroke(red(c), green(c), blue(c), alpha(c));
        vertex(P.x, P.y, P.z);
      } else if ((P.y*P.y+P.z*P.z)<25.00) {
        stroke(red(c), green(c), blue(c), alpha(c)*(25-d2)*0.0625);
        vertex(P.x, P.y, P.z);
      } else {
        endShape(OPEN);
        beginShape();
      }
    }
    endShape(OPEN);
  }
}




static class Quaternion {
  float a, b, c, d; 
  static final Quaternion K=new Quaternion(0, 0, 0, 1);

  Quaternion(float a, float b, float c, float d) {
    this.a=a;
    this.b=b;
    this.c=c;
    this.d=d;
  }

  Quaternion conjugate() {
    return new Quaternion(a, -b, -c, -d);
  }

  Quaternion inverse() {
    return conjugate().mulSelf(1.0/(a*a+b*b+c*c+d*d));
  }

  Quaternion mulSelf(float f) {
    a*=f;
    b*=f;
    c*=f;
    d*=f;
    return this;
  }

  Quaternion mul(float f) {
    return new Quaternion(a*f, b*f, c*f, d*f);
  }

  Quaternion mulSelf(Quaternion other) {
    float newA=a*other.a - b*other.b-c*other.c-d*other.d;
    float newB=a*other.b + b*other.a+c*other.d-d*other.c;
    float newC=a*other.c - b*other.d+c*other.a+d*other.b;
    float newD=a*other.d + b*other.c-c*other.b+d*other.a;
    a=newA;
    b=newB;
    c=newC;
    d=newD;
    return this;
  }

  Quaternion mul(Quaternion other) {
    return new Quaternion(a, b, c, d).mulSelf(other);
  }

  Quaternion mulLeftSelf(Quaternion other) {
    float newA=other.a*a - other.b*b-other.c*c-other.d*d;
    float newB=other.a*b + other.b*a+other.c*d-other.d*c;
    float newC=other.a*c - other.b*d+other.c*a+other.d*b;
    float newD=other.a*d + other.b*c-other.c*b+other.d*a;
    a=newA;
    b=newB;
    c=newC;
    d=newD;
    return this;
  }

  Quaternion mulLeft(Quaternion other) {
    return other.mul(this);
  }

  Point project() {   
    return new Point(b/(1.0-a), c/(1.0-a), d/(1.0-a));
  }
}

static class Point {
  float x, y, z; 
  Point(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;
  }
}
