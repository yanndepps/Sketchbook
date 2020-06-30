static class Point {
  float x, y;
  Point(float x, float y) {
    this.x=x;
    this.y=y;
  }

  boolean inTriangle(Point A, Point B, Point C) {  
    Vector v0 = new Vector(A,C);
    Vector v1 = new Vector(A,B);
    Vector v2 = new Vector(A,this);
    float dot00 = v0.dot(v0);
    float dot01 = v0.dot(v1);
    float dot02 = v0.dot(v2);
    float dot11 = v1.dot(v1);
    float dot12 = v1.dot(v2);
    float invDenom = 1.0 / (dot00 * dot11 - dot01 * dot01);
    float u = (dot11 * dot02 - dot01 * dot12) * invDenom;
    float v = (dot00 * dot12 - dot01 * dot02) * invDenom;
    return u > 0.00001 && v > 0.00001 && u + v < 0.99999;
  }
  
  static Point interpolate(Point a, Point b, float f){
    return new Point(a.x+f*(b.x-a.x),a.y+f*(b.y-a.y));
  }
}

static class Vector {
  float x, y;
  Vector(float x, float y) {
    this.x=x;
    this.y=y;
  }
  
  Vector(Point start, Point end) {
    this.x=end.x-start.x;
    this.y=end.y-start.y;
  }
  
  float dot(Vector v){
   return x*v.x+y*v.y; 
  }  
}
