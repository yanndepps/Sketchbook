static class Polygon {
  Point[] points;
  int numPoints;
  Polygon(Point... points) {
    numPoints=points.length;
    this.points=new Point[numPoints];
    int index=0;
    for (Point p : points) {
      this.points[index++]=p;
    }
  }

  void draw(PApplet home) {
    home.beginShape();
    for (Point p : points) {
      home.vertex(p.x, p.y);
    }
    home.endShape(CLOSE);
  }
  
  Point centroid(){
   final Point c = new Point(0,0);
    for (final Point point : points) {
      c.x+=point.x;
      c.y+=point.y;
    }
    c.x/=numPoints;
    c.y/=numPoints;
    return c;   
  }
}

static class Triangle extends Polygon {
  Triangle(Point... points) {
    super(points);
  } 
}

static class Quad extends Polygon {
  Quad(Point... points) {
    super(points);
  }

  boolean isConvex() {
    if (points[0].inTriangle(points[1], points[2], points[3])) {
      return false;
    }
    if (points[1].inTriangle(points[0], points[2], points[3])) {
      return false;
    }
    if (points[2].inTriangle(points[0], points[1], points[3])) {
      return false;
    }
    if (points[3].inTriangle(points[0], points[1], points[2])) {
      return false;
    }
    return true;
  }
}

static class Pentagon extends Polygon {
  Pentagon(Point... points) {
    super(points);
  }
}

static class Hexagon extends Polygon {
  Hexagon(Point... points) {
    super(points);
  }
}

static class Octagon extends Polygon {
  Octagon(Point... points) {
    super(points);
  }
}
