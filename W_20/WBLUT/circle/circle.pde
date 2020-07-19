ArrayList<Circle> circles;
ArrayList<Circle> intersections;
ArrayList<Circle> intersections2;
ArrayList<Circle> intersections3;

void setup() {
  fullScreen(P3D);
  smooth(16);
  create();
  intersect();
  sphereDetail(24);
}

void create() {
  circles=new ArrayList<Circle>();
  for (int i=0; i<4; i++) {
    circles.add(circleOnSphere(350, random(350), random(PI), random(TWO_PI)));
  }
}

void intersect() {
  intersections=new ArrayList<Circle>(); 
  for (int i=0; i<circles.size(); i++) {
    for (int j=i+1; j<circles.size(); j++) {
      Circle intersection = sphereSphereIntersection(circles.get(i), circles.get(j));
      if (intersection!=null) {
        intersections.add(intersection);
      }
    }
  }
  intersections2=new ArrayList<Circle>();
  for (int i=0; i<intersections.size(); i++) {
    for (int j=i+1; j<intersections.size(); j++) {
      Circle intersection = sphereSphereIntersection(intersections.get(i), intersections.get(j));
      if (intersection!=null) {
        intersections2.add(intersection);
      }
    }
  }
  intersections3=new ArrayList<Circle>();
  for (int i=0; i<intersections2.size(); i++) {
    for (int j=i+1; j<intersections2.size(); j++) {
      Circle intersection = sphereSphereIntersection(intersections2.get(i), intersections2.get(j));
      if (intersection!=null) {
        intersections3.add(intersection);
      }
    }
  }
}

Circle circleOnSphere(float sphereRadius, float distance, float inclination, float azimuth) {
  float ci=cos(inclination);
  float si=sin(inclination);
  float ca=cos(azimuth);
  float sa=sin(azimuth);
  Vector normal=new Vector(si*ca, si*sa, ci);
  Point center=new Point(distance*normal.x, distance*normal.y, distance*normal.z);
  float h=sphereRadius-distance;
  float r=sqrt(2*sphereRadius*h-h*h);
  return new Circle(center, r, normal);
}

Circle sphereSphereIntersection(Circle C1, Circle C2) {
  Vector d=new Vector(C2.center.x-C1.center.x, C2.center.y-C1.center.y, C2.center.z-C1.center.z);
  float dist=d.normalize();
  float R=C1.radius;
  float r=C2.radius;
  float disc=dist*dist-r*r+R*R;
  disc*=disc;
  disc=4*dist*dist*R*R-disc;
  if (disc<0) return null;
  float h=(dist * dist - r * r + R * R) / (2.0 * dist);
  float a=sqrt(disc)/(2.0*dist);
  Point c=new Point(C1.center.x+h*d.x, C1.center.y+h*d.y, C1.center.z+h*d.z);
  return new Circle(c, a, d);
}

void draw() {
  background(15);
  translate(width/2, height/2);
  lights();
  rotateY(map(mouseX, 0, width, -PI, PI));
  rotateX(map(mouseY, 0, height, PI, -PI));
  noFill();

  stroke(240);
  strokeWeight(1.0);
  for (Circle circle : circles) {
    circle.draw(256);
  }
  strokeWeight(1.0);
  stroke(240, 0, 0);
  for (Circle intersection : intersections) {
    intersection.draw(256);
  }

  stroke(180, 0, 0);
  for (Circle intersection : intersections2) {
    intersection.draw(256);
  }
  stroke(100, 0, 0);
  for (Circle intersection : intersections3) {
    intersection.draw(256);
  }
}

void mousePressed() {
  create();
  intersect();
}


class Point {
  float x, y, z;

  Point(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;
  }
}


class Vector {
  float x, y, z;

  Vector(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;
  }

  float normalize() {
    float d=sqrt(x*x+y*y+z*z);
    if (abs(d)>0.0001) {
      x/=d;
      y/=d;
      z/=d;
    }
    return d;
  }

  void mul(float f) {
    x*=f;
    y*=f;
    z*=f;
  }

  Vector cross(Vector v) {
    return new Vector(y*v.z-z*v.y, z*v.x-x*v.z, x*v.y-y*v.x);
  }
}

class Circle {
  Point center;
  Vector normal;
  float radius;
  Point generator;

  Circle(Point center, float radius, Vector normal) {
    this.center=new Point(center.x, center.y, center.z); 
    this.radius=radius;
    this.normal=new Vector(normal.x, normal.y, normal.z);
    this.normal.normalize();
    createGenerator();
  }

  void createGenerator() {
    Vector Y=new Vector(0, 1, 0);
    Vector r=Y.cross(normal);
    if ( r.normalize()<0.0001) r=new Vector(0, 0, 1);
    r.mul(radius);
    generator=new Point(r.x, r.y, r.z);
  }

  void draw(int n) {
    beginShape();
    for (int i=0; i<n; i++) {
      circleVertex(i*TWO_PI/n);
    }
    endShape(CLOSE);
  }

  void drawSphere() {
    pushMatrix();
    translate(center.x, center.y, center.z);
    sphere(radius-2.0);
    popMatrix();
  }

  void circleVertex(float angle) {
    float vx, vy, vz;
    float ca = cos(angle);
    float sa = sin(angle);

    vx = center.x;
    vx+=(ca + (1 - ca) * normal.x * normal.x) * generator.x;
    vx += ((1 - ca) * normal.x * normal.y - normal.z * sa) * generator.y;
    vx += ((1 - ca) * normal.x * normal.z + normal.y * sa) * generator.z;

    vy = center.y;
    vy += ((1 - ca) * normal.x * normal.y + normal.z * sa) * generator.x;
    vy += (ca + (1 - ca) * normal.y * normal.y) * generator.y;
    vy += ((1 - ca) * normal.y * normal.z - normal.x * sa) * generator.z;

    vz = center.z;
    vz += ((1 - ca) * normal.x * normal.z - normal.y * sa) * generator.x;
    vz += ((1 - ca) * normal.y * normal.z + normal.x * sa) * generator.y;
    vz += (ca + (1 - ca) * normal.z * normal.z) * generator.z;
    vertex(vx, vy, vz);
  }
}
