class Tracer {
  Ray ray;
  float cutoff;
  float precision;
  float t;
  float closestDistance;
  int steps;
  int MAXSTEPS=10000;
  Point p;

  Tracer(Point origin, Vector direction, float cutoff, float precision) {
    ray=new Ray(origin, direction);
    this.cutoff=cutoff;
    this.precision=precision;
    initialize();
  }
  
  void initialize(){
    closestDistance= Float.POSITIVE_INFINITY;
    t=0;
    steps=0;
    p=ray.get(0);
  }

  void trace(SDF sdf) {
    p=null;
    t=0.0;
    steps=0;
    do {
      traceStep(sdf);
      steps++;
    } while (!onSurface() && t<cutoff && steps<MAXSTEPS);
    if (t>cutoff) t=cutoff;
    p=ray.get(t);
  }
  
  void traceStep(SDF sdf){
    float d=sdf.signedDistance(ray.get(t));
    if (d<closestDistance) closestDistance=d;
    t+=d;
  }
  
  boolean onSurface(){
    return closestDistance<=precision;
  }

  void reset() {
    initialize();
  }
}

//Interface that implements a signed distance function
interface SDF {
  float signedDistance(Point p);
}

//Implementation of SDF that gives signed distance to sphere
class SphereSDF implements SDF {
  float radius;
  
  SphereSDF(float r) {
    radius=r;
  }
  
  float signedDistance(Point p) {
    return sqrt(sq(p.x)+sq(p.y)+sq(p.z))-radius;
  }
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
}

class Ray {
  Point origin;
  Vector direction;

  Ray(Point origin, Vector direction) {
    this.origin=new Point(origin.x, origin.y, origin.z);
    float mag=direction.x*direction.x+direction.y*direction.y+direction.z*direction.z;
    assert(mag>0.000001);
    mag=1.0/sqrt(mag);
    this.direction=new Vector(direction.x*mag, direction.y*mag, direction.z*mag);
  }

  //Get point on ray at distance t from origin
  Point get(float t) {
    return new Point(origin.x+t*direction.x, origin.y+t*direction.y, origin.z+t*direction.z);
  }
}
