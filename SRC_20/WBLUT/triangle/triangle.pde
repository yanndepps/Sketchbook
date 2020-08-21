Triangle start;
ArrayList<Triangle> triangles;
int MAX_ITERATIONS;
int iterations;
float RANDOMNESS;
float CHANCE;
void setup() {
  size(1000, 500, P3D);
  smooth(16);
  iterations=0;
  MAX_ITERATIONS=12;
  RANDOMNESS=0;
  CHANCE=100;
  create();
}

void create() {
  float radius=250;
  triangles=new ArrayList<Triangle>();
  Point p1=new Point(0, radius);
  Point p2=p1.rotate(radians(120));
  Point p3=p1.rotate(radians(240));
  start=new Triangle(p1, p2, p3);
  triangles.add(start);
}

void draw() {
  background(15);
  translate(width/2, height/2-50);
  for (Triangle triangle : triangles) {
    triangle.draw();
  }
}

void subdivide() {
  if (iterations<MAX_ITERATIONS) {
    iterations++; 
    ArrayList<Triangle> subTriangles=new ArrayList<Triangle>();
    Point p1, p2, p3, pc;
    for (Triangle triangle : triangles) {
      float roll=random(100.0);
      if (roll<CHANCE) {
        p1=triangle.p1;
        p2=triangle.p2;
        p3=triangle.p3;
        pc=triangle.pointInTriangle(RANDOMNESS);
        subTriangles.add(new Triangle(p1, p2, pc));
        subTriangles.add(new Triangle(p2, p3, pc));
        subTriangles.add(new Triangle(p3, p1, pc));
      } else {
        subTriangles.add(triangle);
      }
    }
    triangles=subTriangles;
  }
}

void mousePressed() {
  subdivide();
}

class Point {
  float x, y;
  Point(float x, float y) {
    this.x=x;
    this.y=y;
  }

  Point rotate(float angle) {
    float ca=cos(angle);
    float sa=sin(angle);
    float rotx=ca*x-sa*y;
    float roty=sa*x+ca*y;
    return new Point(rotx, roty);
  }
}

class Triangle {
  Point p1, p2, p3;
  Triangle(Point p1, Point p2, Point p3) {
    this.p1=new Point(p1.x, p1.y);
    this.p2=new Point(p2.x, p2.y);
    this.p3=new Point(p3.x, p3.y);
  }

  void draw() {
    fill(240);
    stroke(0, 80);
    triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
  }

  Point pointInTriangle(float f) {
    float a, b, c;
    do {
      a=random(1.0);
      b=random(1.0);
    } while (a+b>1.0);
    a=1.0/3.0+f*(a-1.0/3.0);
    b=1.0/3.0+f*(b-1.0/3.0);
    c=1-a-b;
    return new Point(a*p1.x+b*p2.x+c*p3.x, a*p1.y+b*p2.y+c*p3.y);
  }
}
