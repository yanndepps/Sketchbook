// we're going to shoot particles, Tracers, into the scene along
// straight paths. when they hit something, they stop. 
// otherwise they come to a stop after a certain distance.
// if our collision geometry would be defined by meshes, we could try
// to intersect the ray of the particles with the faces of the geometry.
// however, in this case, the whole point of this tutorial, we define 
// the geometry by signed distance functions. so, we will use sphere tracing
// to find collisions.
// see : https://wblut.com/the-wrong-way-to-use-a-signed-distance-function/

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
    ray = new Ray(origin, direction);
    this.cutoff = cutoff;
    this.precision = precision;
    initialize();
  }

  void initialize() {
    closestDistance = Float.POSITIVE_INFINITY;
    t = 0;
    steps = 0;
    p = ray.get(0);
  }

  void trace(SDF sdf) {
    p = null;
    t = 0.0;
    steps = 0;
    do {
      traceStep(sdf);
      steps++;
    } while (!onSurface() && t<cutoff && steps<MAXSTEPS);
    if (t>cutoff) t=cutoff;
    p = ray.get(t);
  }

  void traceStep(SDF sdf) {
    float d = sdf.signedDistance(ray.get(t));
    if (d<closestDistance) closestDistance=d;
    t+=d;
  }

  boolean onSurface() {
    return closestDistance <= precision;
  }

  void reset() {
    initialize();
  }
}

// each 'Tracer' starts in a Point origin, along a Vector direction.
// since our particles only move in a straight line, we store them as a 'Ray'.
// we also need to define when we stop tracing the particles : we check if 
// the distance becomes smaller than some value 'precision'. 
// if the tracer doesn't hit, we want to stop after a certain distance, called
// cutoff.
// to be safe, we limit the max number of steps our tracer can take, 'MAXSTEPS'.
// the current state of 'Tracer' is held in 4 variables :
// - t : the current distance traveled along ray.
// - closestDistance : the closest the particle has come to the surface so far.
// - steps : the number of steps taken so far.
// - p : the current position of the particle along the ray.
// at every step, the signed distance function is checked, and the particle is
// moved that distance forward along the ray. the tracing is stopped once one of
// three conditions is met :
// - closestDistance < precision : the particle has come closer to the surface than our precision threshold : collision.
// - t >= cutoff : the distance traveled along the ray exceeds the cutoff distance : no collision.
// - steps >= MAXSTEPS : the number of steps taken exceeds the max number allowed. this should only occur when we've made a mistake in the code.
// in any case, at the end of the trace, the particle is either on the surface or beyond our region of interest.

// interface that implements a signed distance function
// an interface is a completely 'abstract class' that is 
// used to group related methods with empty bodies.
// consider it a 'promise' to Processing.
// everything we identify as a 'SDF' will have this function
// signedDistance(Point p) that returns a float.
// an interface can be used to define variables, to pass objects to functions,
// pretty much everywhere we can use a class. what we can't do, is create a new
// object with 'new SDF()'.
interface SDF {
  float signedDistance(Point p);
}

// implementation of SDF that gives signed distance to sphere
class SphereSDF implements SDF {
  float radius;
  SphereSDF(float r) {
    radius=r;
  }

  float signedDistance(Point p) {
    return sqrt(sq(p.x)+sq(p.y)+sq(p.z))-radius;
  }
}

// we tell Processing that this class implements 'SDF'. In return,
// we need to fulfill our promise and implement 'signedDistance(Point p)'.
// Everywhere Processing expects a 'SDF' we can now pass a SphereSDF and it 
// will work.
// similarly, we can define the sdf of a box at the origin of size X, Y and Z.
/*
GLSL code https://iquilezles.org/www/articles/distfunctions/distfunctions.htm
float sdBox( vec3 p, vec3 b )
{
  vec3 q = abs(p) - b;
  return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0);
}
*/
class BoxSDF implements SDF {
  float X, Y, Z;
  BoxSDF(float x, float y, float z) {
    X=x;
    Y=y;
    Z=z;
  }

  float signedDistance(Point p) {
    float qx = max(abs(p.x)-X, 0);
    float qy = max(abs(p.y)-Y, 0);
    float qz = max(abs(p.z)-Z, 0);
    return sqrt(qx*qx+qy*qy+qz*qz)+min(max(qx, qy, qz), 0.0);
  }
}

// we could have used PVector instead of creating
// Point and Vector, but it's easier to talk about
// points and vectors with as little abstraction as possible.
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

// a half line starting at a Point origin, the direction is 
// given by the Vector direction. On creation, direction is 
// normalized, its length is rescaled to 1.0.
// The function 'get(t)' will return a new Point on the ray,
// a distance 't' from its origin :
class Ray {
  Point origin;
  Vector direction;

  Ray(Point origin, Vector direction) {
    this.origin = new Point(origin.x, origin.y, origin.z);
    float mag = direction.x * direction.x + direction.y * direction.y +   direction.z * direction.z;
    assert(mag > 0.000001);
    mag = 1.0 / sqrt(mag);
    this.direction = new Vector(direction.x * mag, direction.y * mag, direction.z * mag);
  }

  // get point on ray at distance t from origin
  Point get(float t) {
    return new Point(origin.x + t * direction.x, origin.y + t * direction.y, origin.z + t * direction.z);
  }
}
