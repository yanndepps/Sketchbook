TriangleSubdivision[] TSubs = new TriangleSubdivision[] { new T01(), new T02(), new T03(), 
  /*new T04(),  new T05(),*/ new T06(), new T07(), new T08(), new T09(), new T10(), new T11(), new T12(), 
  new T13(), new T14() };//

QuadSubdivision[] QSubs = new QuadSubdivision[] { new Q01(), new Q02(),/* new Q03(),*/ new Q04(), 
  new Q05(), new Q06(), new Q07(), new Q08(), new Q09(), new Q10(), new Q11(), new Q12(), new Q13(), 
  /*new Q14(), new Q15(), new Q16(),*/ new Q17() };  

PentagonSubdivision[] PSubs = new PentagonSubdivision[] { new P01(), new P02(), new P03(), 
  new P04(), new P05(), new P06(), new P07(), new P08(),new P09(), /*new P10(),*/ new P11() };
  
HexagonSubdivision[] HSubs = new HexagonSubdivision[] { new H01(), new H02(), new H03(), 
  new H04(), new H05(), new H06(), new H07(), new H08(), new H09(),/*new H10(),*/ new H11() };

OctagonSubdivision[] OSubs = new OctagonSubdivision[] { new O01(), new O02(), new O03(), 
  new O04(), new O05(), new O06(), new O07(), new O08(), new O09(), new O10(), new O11(), new O12(), 
  new O13(), new O14() };


static interface TriangleSubdivision {
  SubdivisionResult apply(Triangle triangle);
}

static class T00 implements TriangleSubdivision {
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    result.addTriangle(p1, p2, p3);
    return result;
  }
}

static class T01 implements TriangleSubdivision {
  private int n = 2;
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    Point[] q = new Point[n - 1];
    float f = 1.0 / n;
    for (int i = 0; i < n - 1; i++) {
      q[i] = Point.interpolate(p2, p3, f);
      f += 1.0 / n;
    }
    result.addTriangle(p1, q[0], p3);
    for (int i = 1; i < n - 2; i++) {
      result.addTriangle(p1, q[i], q[i - 1]);
    }
    result.addTriangle(p1, p2, q[n - 2]);
    return result;
  }

  T01 setN(final int nn) {
    if (nn > 0) {
      n = nn;
    } else {
      n = 2;
    }
    return this;
  }
}

static class T02 implements TriangleSubdivision {
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    Point q = triangle.centroid();
    result.addTriangle(q, p2, p3);
    result.addTriangle(q, p3, p1);
    result.addTriangle(q, p1, p2);
    return result;
  }
}

static class T03 implements TriangleSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    Point q12 = Point.interpolate(p1, p2, f);
    Point q23 = Point.interpolate(p2, p3, 0.5);
    Point q31 = Point.interpolate(p1, p3, f);
    result.addTriangle(p1, q12, q31);
    result.addTriangle(p2, q23, q12);
    result.addTriangle(p3, q31, q23);
    result.addTriangle(q23, q31, q12);
    return result;
  }

  T03 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class T04 implements TriangleSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    Point q12 = Point.interpolate(p1, p2, f);
    Point q31 = Point.interpolate(p1, p3, f);
    result.addTriangle(p1, q12, q31);
    result.addQuad(q31, q12, p2, p3);
    return result;
  }

  T04 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class T05 implements TriangleSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    Point q12 = Point.interpolate(p1, p2, f);
    Point q23 = Point.interpolate(p2, p3, 0.5);
    Point q31 = Point.interpolate(p1, p3, f);
    result.addQuad(p1, q12, q23, q31);
    result.addTriangle(q12, p2, q23);
    result.addTriangle(q31, q23, p3);
    return result;
  }

  T05 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class T06 implements TriangleSubdivision {
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    Point q12 = Point.interpolate(p1, p2, 0.5);
    Point q23 = Point.interpolate(p2, p3, 0.5);
    Point q31 = Point.interpolate(p3, p1, 0.5);
    Point q = triangle.centroid();
    result.addQuad(p1, q12, q, q31);
    result.addQuad(p2, q23, q, q12);
    result.addQuad(p3, q31, q, q23);
    return result;
  }
}

static class T07 implements TriangleSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    Point q12 = Point.interpolate(p1, p2, 0.5);
    Point q23 = Point.interpolate(p2, p3, 0.5);
    Point q31 = Point.interpolate(p3, p1, 0.5);
    Point q = triangle.centroid();
    q12 = Point.interpolate(q, q12, f);
    q23 = Point.interpolate(q, q23, f);
    q31 = Point.interpolate(q, q31, f);
    result.addQuad(p1, q12, q, q31);
    result.addQuad(p2, q23, q, q12);
    result.addQuad(p3, q31, q, q23);
    result.addTriangle(q23, p2, p3);
    result.addTriangle(q31, p3, p1);
    result.addTriangle(q12, p1, p2);
    return result;
  }

  T07 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class T08 implements TriangleSubdivision {
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    Point q12 = Point.interpolate(p1, p2, 0.5);
    Point q23 = Point.interpolate(p2, p3, 0.5);
    Point q31 = Point.interpolate(p3, p1, 0.5);
    Point q = triangle.centroid();
    result.addTriangle(p1, q, q31);
    result.addTriangle(p1, q12, q);
    result.addTriangle(p2, q, q12);
    result.addTriangle(p2, q23, q);
    result.addTriangle(p3, q, q23);
    result.addTriangle(p3, q31, q);
    return result;
  }
}

static class T09 implements TriangleSubdivision {
  private float f = 1.0 / 3.0;
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    Point q12a = Point.interpolate(p1, p2, f);
    Point q12b = Point.interpolate(p1, p2, 1.0 - f);
    Point q23a = Point.interpolate(p2, p3, f);
    Point q23b = Point.interpolate(p2, p3, 1.0 - f);
    Point q31a = Point.interpolate(p3, p1, f);
    Point q31b = Point.interpolate(p3, p1, 1.0 - f);
    Point q = triangle.centroid();

    result.addQuad(p1, q12a, q, q31b);
    result.addQuad(p2, q23a, q, q12b);
    result.addQuad(p3, q31a, q, q23b);
    result.addTriangle(q, q23a, q23b);
    result.addTriangle(q, q31a, q31b);
    result.addTriangle(q, q12a, q12b);
    return result;
  }

  T09 setF(final float ff) {
    if (ff > 0 && ff < 0.5) {
      f = ff;
    } else {
      f = 1.0 / 3.0;
    }
    return this;
  }
}

static class T10 implements TriangleSubdivision {
  private float f = 1.0 / 3.0;
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];

    Point q23a = Point.interpolate(p2, p3, f);
    Point q23b = Point.interpolate(p2, p3, 1.0 - f);
    result.addTriangle(p1, q23b, p3);
    result.addTriangle(p1, q23a, q23b);
    result.addTriangle(p1, p2, q23a);
    return result;
  }

  T10 setF(final float ff) {
    if (ff > 0 && ff < 0.5) {
      f = ff;
    } else {
      f = 1.0 / 3.0;
    }
    return this;
  }
}

static class T11 implements TriangleSubdivision {
  private float f = 1.0 / 3.0;
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    Point q12a = Point.interpolate(p1, p2, f);
    Point q12b = Point.interpolate(p1, p2, 1.0 - f);
    Point q23a = Point.interpolate(p2, p3, f);
    Point q23b = Point.interpolate(p2, p3, 1.0 - f);
    Point q31a = Point.interpolate(p3, p1, f);
    Point q31b = Point.interpolate(p3, p1, 1.0 - f);
    result.addTriangle(p1, q12a, q31b);
    result.addTriangle(p2, q23a, q12b);
    result.addTriangle(p3, q31a, q23b);
    result.addHexagon(q31b, q12a, q12b, q23a, q23b, q31a);

    return result;
  }

  T11 setF(final float ff) {
    if (ff > 0 && ff < 0.5) {
      f = ff;
    } else {
      f = 1.0 / 3.0;
    }
    return this;
  }
}

static class T12 implements TriangleSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    Point q12 = Point.interpolate(p1, p2, 0.5);
    Point q23 = Point.interpolate(p2, p3, 0.5);
    Point q31 = Point.interpolate(p3, p1, 0.5);
    Point q = triangle.centroid();
    q12 = Point.interpolate(q, q12, f);
    q23 = Point.interpolate(q, q23, f);
    q31 = Point.interpolate(q, q31, f);
    result.addTriangle(p1, q12, q31);
    result.addTriangle(p2, q23, q12);
    result.addTriangle(p3, q31, q23);
    result.addTriangle(q23, p2, p3);
    result.addTriangle(q31, p3, p1);
    result.addTriangle(q12, p1, p2);
    result.addTriangle(q23, q31, q12);
    return result;
  }

  T12 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class T13 implements TriangleSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p31 = Point.interpolate(p3, p1, 0.5);
    Point q = triangle.centroid();
    Point q12 = Point.interpolate(q, p12, f);
    Point q23 = Point.interpolate(q, p23, f);
    Point q31 = Point.interpolate(q, p31, f);
    result.addPentagon(p1, p12, q12, q31, p31);
    result.addPentagon(p2, p23, q23, q12, p12);
    result.addPentagon(p3, p31, q31, q23, p23);
    result.addTriangle(q23, q31, q12);
    return result;
  }

  T13 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class T14 implements TriangleSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Triangle triangle) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = triangle.points[0];
    Point p2 = triangle.points[1];
    Point p3 = triangle.points[2];

    Point q = triangle.centroid();
    Point q1 = Point.interpolate(q, p1, f);
    Point q2 = Point.interpolate(q, p2, f);
    Point q3 = Point.interpolate(q, p3, f);
    result.addTriangle(q1, q2, q3);
    result.addQuad(p1, p2, q2, q1);
    result.addQuad(p2, p3, q3, q2);
    result.addQuad(p3, p1, q1, q3);
    return result;
  }

  T14 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}



interface QuadSubdivision {
  SubdivisionResult apply(Quad quad);
}

static class Q01 implements QuadSubdivision {

  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p41 = Point.interpolate(p1, p4, 0.5);
    result.addQuad(p12, p23, p34, p41);
    result.addTriangle(p1, p12, p41);
    result.addTriangle(p2, p23, p12);
    result.addTriangle(p3, p34, p23);
    result.addTriangle(p4, p41, p34);
    return result;
  }
}

static class Q02 implements QuadSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point q = quad.centroid();
    Point q1 = Point.interpolate(p1, q, f);
    Point q2 = Point.interpolate(p2, q, f);
    Point q3 = Point.interpolate(p3, q, f);
    Point q4 = Point.interpolate(p4, q, f);
    result.addQuad(q1, q2, q3, q4);
    result.addQuad(p1, p2, q2, q1);
    result.addQuad(p2, p3, q3, q2);
    result.addQuad(p3, p4, q4, q3);
    result.addQuad(p4, p1, q1, q4);
    return result;
  }

  Q02 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class Q03 implements QuadSubdivision {
  private int n = 3;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];

    Point[] q12 = new Point[n - 1];
    Point[] q13 = new Point[n - 1];
    Point[] q14 = new Point[n - 1];

    float f = 1.0 / n;
    for (int i = 0; i < n - 1; i++) {
      q12[i] = Point.interpolate(p1, p2, f);
      q13[i] = Point.interpolate(p1, p3, f);
      q14[i] = Point.interpolate(p1, p4, f);
      f += 1.0 / n;
    }
    result.addTriangle(p1, q14[0], q13[0]);
    result.addTriangle(p1, q12[0], q13[0]);
    for (int i = 0; i < n - 2; i++) {
      result.addQuad(q13[i], q13[i + 1], q14[i + 1], q14[i]);
      result.addQuad(q13[i], q12[i], q12[i + 1], q13[i + 1]);
    }
    result.addQuad(q13[n - 2], p3, p4, q14[n - 2]);
    result.addQuad(q13[n - 2], q12[n - 2], p2, p3);
    return result;
  }

  Q03 setN(final int nn) {
    if (nn > 0) {
      n = nn;
    } else {
      n = 3;
    }
    return this;
  }
}

static class Q04 implements QuadSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point q12 = Point.interpolate(p1, p2, 0.5);
    Point q23 = Point.interpolate(p2, p3, 0.5);
    Point q34 = Point.interpolate(p3, p4, 0.5);
    Point q41 = Point.interpolate(p1, p4, 0.5);
    Point q = quad.centroid();
    Point q1 = Point.interpolate(p1, q, f);
    Point q2 = Point.interpolate(p2, q, f);
    Point q3 = Point.interpolate(p3, q, f);
    Point q4 = Point.interpolate(p4, q, f);
    result.addTriangle(p1, q1, q41);
    result.addTriangle(p1, q12, q1);
    result.addQuad(q, q41, q1, q12);
    result.addTriangle(p2, q2, q12);
    result.addTriangle(p2, q23, q2);
    result.addQuad(q, q12, q2, q23);
    result.addTriangle(p3, q3, q23);
    result.addTriangle(p3, q34, q3);
    result.addQuad(q, q23, q3, q34);
    result.addTriangle(p4, q4, q34);
    result.addTriangle(p4, q41, q4);
    result.addQuad(q, q34, q4, q41);
    return result;
  }

  Q04 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class Q05 implements QuadSubdivision {
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point q12 = Point.interpolate(p1, p2, 0.5);
    Point q23 = Point.interpolate(p2, p3, 0.5);
    Point q34 = Point.interpolate(p3, p4, 0.5);
    Point q41 = Point.interpolate(p1, p4, 0.5);
    Point q = quad.centroid();
    result.addTriangle(p1, q, q41);
    result.addTriangle(p1, q12, q);
    result.addTriangle(p2, q, q12);
    result.addTriangle(p2, q23, q);
    result.addTriangle(p3, q, q23);
    result.addTriangle(p3, q34, q);
    result.addTriangle(p4, q, q34);
    result.addTriangle(p4, q41, q);
    return result;
  }
}

static class Q06 implements QuadSubdivision {
  private float f = 1.0 / 3.0;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point q12a = Point.interpolate(p1, p2, f);
    Point q12b = Point.interpolate(p1, p2, 1.0 - f);
    Point q23a = Point.interpolate(p2, p3, f);
    Point q23b = Point.interpolate(p2, p3, 1.0 - f);
    Point q34a = Point.interpolate(p3, p4, f);
    Point q34b = Point.interpolate(p3, p4, 1.0 - f);
    Point q41a = Point.interpolate(p1, p4, f);
    Point q41b = Point.interpolate(p1, p4, 1.0 - f);
    Point q = quad.centroid();
    result.addQuad(p1, q12a, q, q41a);
    result.addQuad(p2, q23a, q, q12b);
    result.addQuad(p3, q34a, q, q23b);
    result.addQuad(p4, q41b, q, q34b);
    result.addTriangle(q, q41b, q41a);
    result.addTriangle(q, q12a, q12b);
    result.addTriangle(q, q23a, q23b);
    result.addTriangle(q, q34a, q34b);
    return result;
  }

  Q06 setF(final float ff) {
    if (ff > 0 && ff < 0.5) {
      f = ff;
    } else {
      f = 1.0 / 3.0;
    }
    return this;
  }
}

static class Q07 implements QuadSubdivision {
  private float f = 1.0 / 3.0;
  private float g = 0.5;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point q12a = Point.interpolate(p1, p2, f);
    Point q12b = Point.interpolate(p1, p2, 1.0 - f);
    Point q23a = Point.interpolate(p2, p3, f);
    Point q23b = Point.interpolate(p2, p3, 1.0 - f);
    Point q34a = Point.interpolate(p3, p4, f);
    Point q34b = Point.interpolate(p3, p4, 1.0 - f);
    Point q41a = Point.interpolate(p1, p4, f);
    Point q41b = Point.interpolate(p1, p4, 1.0 - f);
    Point q = quad.centroid();
    Point q1 = Point.interpolate(p1, q, g);
    Point q2 = Point.interpolate(p2, q, g);
    Point q3 = Point.interpolate(p3, q, g);
    Point q4 = Point.interpolate(p4, q, g);
    result.addQuad(p1, q12a, q1, q41a);
    result.addQuad(p2, q23a, q2, q12b);
    result.addQuad(p3, q34a, q3, q23b);
    result.addQuad(p4, q41b, q4, q34b);
    result.addPentagon(q4, q41b, q41a, q1, q);
    result.addPentagon(q1, q12a, q12b, q2, q);
    result.addPentagon(q2, q23a, q23b, q3, q);
    result.addPentagon(q3, q34a, q34b, q4, q);

    return result;
  }

  Q07 setF(final float ff) {
    if (ff > 0 && ff < 0.5) {
      f = ff;
    } else {
      f = 1.0 / 3.0;
    }
    return this;
  }

  Q07 setG(final float gg) {
    if (gg > 0 && gg < 1.0) {
      g = gg;
    } else {
      g = 0.5;
    }
    return this;
  }
}

static class Q08 implements QuadSubdivision {
  private float f = 1.0 / 3.0;
  private float g = 0.5;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point q12a = Point.interpolate(p1, p2, f);
    Point q12b = Point.interpolate(p1, p2, 1.0 - f);
    Point q23a = Point.interpolate(p2, p3, f);
    Point q23b = Point.interpolate(p2, p3, 1.0 - f);
    Point q34a = Point.interpolate(p3, p4, f);
    Point q34b = Point.interpolate(p3, p4, 1.0 - f);
    Point q41a = Point.interpolate(p1, p4, f);
    Point q41b = Point.interpolate(p1, p4, 1.0 - f);
    Point q = quad.centroid();
    Point q1 = Point.interpolate(p1, q, g);
    Point q2 = Point.interpolate(p2, q, g);
    Point q3 = Point.interpolate(p3, q, g);
    Point q4 = Point.interpolate(p4, q, g);
    Point q41 = Point.interpolate(q12a, q34b, 0.5);
    Point q23 = Point.interpolate(q12b, q34a, 0.5);
    result.addQuad(p1, q12a, q1, q41a);
    result.addQuad(p2, q23a, q2, q12b);
    result.addQuad(p3, q34a, q3, q23b);
    result.addQuad(p4, q41b, q4, q34b);
    result.addPentagon(q41, q4, q41b, q41a, q1);
    result.addHexagon(q41, q1, q12a, q12b, q2, q23);
    result.addPentagon(q23, q2, q23a, q23b, q3);
    result.addHexagon(q23, q3, q34a, q34b, q4, q41);
    return result;
  }

  Q08 setF(final float ff) {
    if (ff > 0 && ff < 0.5) {
      f = ff;
    } else {
      f = 1.0 / 3.0;
    }
    return this;
  }

  Q08 setG(final float gg) {
    if (gg > 0 && gg < 1.0) {
      g = gg;
    } else {
      g = 0.5;
    }
    return this;
  }
}

static class Q09 implements QuadSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point q12 = Point.interpolate(p1, p2, f);
    Point q23 = Point.interpolate(p2, p3, f);
    Point q34 = Point.interpolate(p3, p4, f);
    Point q41 = Point.interpolate(p1, p4, f);
    Point q = quad.centroid();
    Point q1 = Point.interpolate(p1, q, f);
    Point q2 = Point.interpolate(p2, q, f);
    Point q3 = Point.interpolate(p3, q, f);
    Point q4 = Point.interpolate(p4, q, f);
    result.addQuad(p1, q12, q1, q41);
    result.addQuad(p2, q23, q2, q12);
    result.addQuad(p3, q34, q3, q23);
    result.addQuad(p4, q41, q4, q34);
    result.addQuad(q1, q12, q2, q);
    result.addQuad(q2, q23, q3, q);
    result.addQuad(q3, q34, q4, q);
    result.addQuad(q4, q41, q1, q);
    return result;
  }

  Q09 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class Q10 implements QuadSubdivision {
  private int n = 3;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point[][] q = new Point[n + 1][n + 1];
    float f = 0;
    Point a, b;
    float g;
    for (int i = 0; i <= n; i++) {
      a = Point.interpolate(p1, p2, f);
      b = Point.interpolate(p4, p3, f);
      g = 0;
      for (int j = 0; j <= n; j++) {
        q[i][j] = Point.interpolate(a, b, g);
        if (j == n - 1) {
          g = 1.0;
        } else {
          g += 1.0 / n;
        }
      }
      if (i == n - 1) {
        f = 1.0;
      } else {
        f += 1.0 / n;
      }
    }
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        result.addQuad(q[i][j], q[i + 1][j], q[i + 1][j + 1], q[i][j + 1]);
      }
    }
    return result;
  }

  Q10 setN(final int nn) {
    if (nn > 0) {
      n = nn;
    } else {
      n = 3;
    }
    return this;
  }
}

static class Q11 implements QuadSubdivision {
  private float f = 1.0 / 3.0;
  private float g = 0.5;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point p12a = Point.interpolate(p1, p2, f);
    Point p12b = Point.interpolate(p1, p2, 1.0 - f);
    Point p23a = Point.interpolate(p2, p3, f);
    Point p23b = Point.interpolate(p2, p3, 1.0 - f);
    Point p34a = Point.interpolate(p3, p4, f);
    Point p34b = Point.interpolate(p3, p4, 1.0 - f);
    Point p41a = Point.interpolate(p1, p4, f);
    Point p41b = Point.interpolate(p1, p4, 1.0 - f);
    Point q = quad.centroid();
    Point q1 = Point.interpolate(p1, q, g);
    Point q2 = Point.interpolate(p2, q, g);
    Point q3 = Point.interpolate(p3, q, g);
    Point q4 = Point.interpolate(p4, q, g);
    Point q12a = Point.interpolate(q1, q2, f);
    Point q12b = Point.interpolate(q1, q2, 1.0 - f);
    Point q23a = Point.interpolate(q2, q3, f);
    Point q23b = Point.interpolate(q2, q3, 1.0 - f);
    Point q34a = Point.interpolate(q3, q4, f);
    Point q34b = Point.interpolate(q3, q4, 1.0 - f);
    Point q41a = Point.interpolate(q1, q4, f);
    Point q41b = Point.interpolate(q1, q4, 1.0 - f);
    result.addPentagon(p1, p12a, q12a, q41a, p41a);
    result.addPentagon(p2, p23a, q23a, q12b, p12b);
    result.addPentagon(p3, p34a, q34a, q23b, p23b);
    result.addPentagon(p4, p41b, q41b, q34b, p34b);
    result.addQuad(p41b, p41a, q41a, q41b);
    result.addQuad(p12a, p12b, q12b, q12a);
    result.addQuad(p23a, p23b, q23b, q23a);
    result.addQuad(p34a, p34b, q34b, q34a);
    result.addOctagon(q41a, q12a, q12b, q23a, q23b, q34a, q34b, q41b);
    return result;
  }

  Q11 setF(final float ff) {
    if (ff > 0 && ff < 0.5) {
      f = ff;
    } else {
      f = 1.0 / 3.0;
    }
    return this;
  }
}

static class Q12 implements QuadSubdivision {
  private float f = 1.0 / 3.0;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point q12a = Point.interpolate(p1, p2, f);
    Point q12b = Point.interpolate(p1, p2, 1.0 - f);
    Point q23a = Point.interpolate(p2, p3, f);
    Point q23b = Point.interpolate(p2, p3, 1.0 - f);
    Point q34a = Point.interpolate(p3, p4, f);
    Point q34b = Point.interpolate(p3, p4, 1.0 - f);
    Point q41a = Point.interpolate(p1, p4, f);
    Point q41b = Point.interpolate(p1, p4, 1.0 - f);
    result.addOctagon(q41a, q12a, q12b, q23a, q23b, q34a, q34b, q41b);
    result.addTriangle(p1, q12a, q41a);
    result.addTriangle(p2, q23a, q12b);
    result.addTriangle(p3, q34a, q23b);
    result.addTriangle(p4, q41b, q34b);
    return result;
  }

  Q12 setF(final float ff) {
    if (ff > 0 && ff < 0.5) {
      f = ff;
    } else {
      f = 1.0 / 3.0;
    }
    return this;
  }
}

static class Q13 implements QuadSubdivision {
  private int n = 3;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point[][] q = new Point[n + 1][2];
    float f = 0;
    Point a, b;
    float g;
    for (int i = 0; i <= n; i++) {
      a = Point.interpolate(p1, p2, f);
      b = Point.interpolate(p4, p3, f);
      g = 0;
      for (int j = 0; j < 2; j++) {
        q[i][j] = Point.interpolate(a, b, g);
        g = 1.0;
      }
      if (i == n - 1) {
        f = 1.0;
      } else {
        f += 1.0 / n;
      }
    }
    for (int i = 0; i < n; i++) {
      result.addQuad(q[i][0], q[i + 1][0], q[i + 1][1], q[i][1]);
    }
    return result;
  }

  Q13 setN(final int nn) {
    if (nn > 0) {
      n = nn;
    } else {
      n = 3;
    }
    return this;
  }
}

static class Q14 implements QuadSubdivision {
  private int n = 3;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point[] q12 = new Point[n - 1];
    Point[] q14 = new Point[n - 1];
    float f = 1.0 / n;
    for (int i = 0; i < n - 1; i++) {
      q12[i] = Point.interpolate(p1, p2, f);
      q14[i] = Point.interpolate(p1, p4, f);
      f += 1.0 / n;
    }
    result.addTriangle(p1, q12[0], q14[0]);
    for (int i = 0; i < n - 2; i++) {
      result.addQuad(q12[i], q12[i + 1], q14[i + 1], q14[i]);
    }
    result.addQuad(q12[n - 2], p2, p4, q14[n - 2]);
    result.addTriangle(p4, p2, p3);
    return result;
  }

  Q14 setN(final int nn) {
    if (nn > 0) {
      n = nn;
    } else {
      n = 3;
    }
    return this;
  }
}

static class Q15 implements QuadSubdivision {
  private int n = 3;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point[] q12 = new Point[n - 1];
    Point[] q14 = new Point[n - 1];
    Point[] q32 = new Point[n - 1];
    Point[] q34 = new Point[n - 1];
    float f = 1.0 / n;
    for (int i = 0; i < n - 1; i++) {
      q12[i] = Point.interpolate(p1, p2, f);
      q14[i] = Point.interpolate(p1, p4, f);
      q32[i] = Point.interpolate(p3, p2, f);
      q34[i] = Point.interpolate(p3, p4, f);
      f += 1.0 / n;
    }
    result.addTriangle(p1, q12[0], q14[0]);
    result.addTriangle(p3, q32[0], q34[0]);
    for (int i = 0; i < n - 2; i++) {
      result.addQuad(q12[i], q12[i + 1], q14[i + 1], q14[i]);
      result.addQuad(q32[i + 1], q32[i], q34[i], q34[i + 1]);
    }
    result.addQuad(q12[n - 2], p2, p4, q14[n - 2]);
    result.addQuad(p2, q32[n - 2], q34[n - 2], p4);
    return result;
  }

  Q15 setN(final int nn) {
    if (nn > 0) {
      n = nn;
    } else {
      n = 3;
    }
    return this;
  }
}

static class Q16 implements QuadSubdivision {
  private int n = 3;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point[] q32 = new Point[n - 1];
    Point[] q34 = new Point[n - 1];
    float f = 1.0 / n;
    for (int i = 0; i < n - 1; i++) {
      q32[i] = Point.interpolate(p3, p2, f);
      q34[i] = Point.interpolate(p3, p4, f);
      f += 1.0 / n;
    }
    result.addQuad(p1, q32[0], p3, q34[0]);
    for (int i = 0; i < n - 2; i++) {
      result.addTriangle(p1, q32[i], q32[i + 1]);
      result.addTriangle(p1, q34[i], q34[i + 1]);
    }
    result.addTriangle(p1, q32[n - 2], p2);
    result.addTriangle(p1, q34[n - 2], p4);
    return result;
  }

  Q16 setN(final int nn) {
    if (nn > 0) {
      n = nn;
    } else {
      n = 3;
    }
    return this;
  }
}

static class Q17 implements QuadSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Quad quad) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = quad.points[0];
    Point p2 = quad.points[1];
    Point p3 = quad.points[2];
    Point p4 = quad.points[3];
    Point q12 = Point.interpolate(p1, p2, f);
    Point q23 = Point.interpolate(p2, p3, f);
    Point q34 = Point.interpolate(p3, p4, f);
    Point q41 = Point.interpolate(p1, p4, f);
    Point q = quad.centroid();
    Point q1 = Point.interpolate(p1, q, f);
    Point q2 = Point.interpolate(p2, q, f);
    Point q3 = Point.interpolate(p3, q, f);
    Point q4 = Point.interpolate(p4, q, f);
    result.addTriangle(p1, q12, q1);
    result.addTriangle(p1, q1, q41);
    result.addTriangle(p2, q2, q12);
    result.addTriangle(p2, q23, q2);
    result.addTriangle(p3, q3, q23);
    result.addTriangle(p3, q34, q3);
    result.addTriangle(p4, q4, q34);
    result.addTriangle(p4, q41, q4);
    result.addQuad(q1, q12, q2, q);
    result.addQuad(q2, q23, q3, q);
    result.addQuad(q3, q34, q4, q);
    result.addQuad(q4, q41, q1, q);
    return result;
  }

  Q17 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

interface PentagonSubdivision {
  SubdivisionResult apply(Pentagon pentagon);
}

static class P01 implements PentagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Pentagon pentagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = pentagon.points[0];
    Point p2 = pentagon.points[1];
    Point p3 = pentagon.points[2];
    Point p4 = pentagon.points[3];
    Point p5 = pentagon.points[4];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p51 = Point.interpolate(p5, p1, 0.5);
    Point q = pentagon.centroid();
    Point q12 = Point.interpolate(p12, q, f);
    Point q23 = Point.interpolate(p23, q, f);
    Point q34 = Point.interpolate(p34, q, f);
    Point q45 = Point.interpolate(p45, q, f);
    Point q51 = Point.interpolate(p51, q, f);
    result.addPentagon(p1, p12, q12, q51, p51);
    result.addPentagon(p2, p23, q23, q12, p12);
    result.addPentagon(p3, p34, q34, q23, p23);
    result.addPentagon(p4, p45, q45, q34, p34);
    result.addPentagon(p5, p51, q51, q45, p45);
    result.addPentagon(q34, q23, q12, q51, q45);
    return result;
  }

  P01 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class P02 implements PentagonSubdivision {
  SubdivisionResult apply(final Pentagon pentagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = pentagon.points[0];
    Point p2 = pentagon.points[1];
    Point p3 = pentagon.points[2];
    Point p4 = pentagon.points[3];
    Point p5 = pentagon.points[4];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p51 = Point.interpolate(p5, p1, 0.5);
    Point q = pentagon.centroid();
    result.addQuad(p1, p12, q, p51);
    result.addQuad(p2, p23, q, p12);
    result.addQuad(p3, p34, q, p23);
    result.addQuad(p4, p45, q, p34);
    result.addQuad(p5, p51, q, p45);
    return result;
  }
}

static class P03 implements PentagonSubdivision {
  SubdivisionResult apply(final Pentagon pentagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = pentagon.points[0];
    Point p2 = pentagon.points[1];
    Point p3 = pentagon.points[2];
    Point p4 = pentagon.points[3];
    Point p5 = pentagon.points[4];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p51 = Point.interpolate(p5, p1, 0.5);
    result.addTriangle(p1, p12, p51);
    result.addTriangle(p2, p23, p12);
    result.addTriangle(p3, p34, p23);
    result.addTriangle(p4, p45, p34);
    result.addTriangle(p5, p51, p45);
    result.addPentagon(p34, p45, p51, p12, p23);
    return result;
  }
}

static class P04 implements PentagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Pentagon pentagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = pentagon.points[0];
    Point p2 = pentagon.points[1];
    Point p3 = pentagon.points[2];
    Point p4 = pentagon.points[3];
    Point p5 = pentagon.points[4];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p51 = Point.interpolate(p5, p1, 0.5);
    Point q = pentagon.centroid();
    Point q1 = Point.interpolate(p1, q, f);
    Point q2 = Point.interpolate(p2, q, f);
    Point q3 = Point.interpolate(p3, q, f);
    Point q4 = Point.interpolate(p4, q, f);
    Point q5 = Point.interpolate(p5, q, f);
    result.addQuad(p1, p12, q1, p51);
    result.addQuad(p2, p23, q2, p12);
    result.addQuad(p3, p34, q3, p23);
    result.addQuad(p4, p45, q4, p34);
    result.addQuad(p5, p51, q5, p45);
    result.addQuad(p34, q4, q, q3);
    result.addQuad(p45, q5, q, q4);
    result.addQuad(p51, q1, q, q5);
    result.addQuad(p12, q2, q, q1);
    result.addQuad(p23, q3, q, q2);
    return result;
  }

  P04 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class P05 implements PentagonSubdivision {
  SubdivisionResult apply(final Pentagon pentagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = pentagon.points[0];
    Point p2 = pentagon.points[1];
    Point p3 = pentagon.points[2];
    Point p4 = pentagon.points[3];
    Point p5 = pentagon.points[4];
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point q = pentagon.centroid();
    result.addQuad(p1, q, p45, p5);
    result.addQuad(p1, p2, p23, q);
    result.addPentagon(q, p23, p3, p4, p45);
    return result;
  }
}

static class P06 implements PentagonSubdivision {
  SubdivisionResult apply(final Pentagon pentagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = pentagon.points[0];
    Point p2 = pentagon.points[1];
    Point p3 = pentagon.points[2];
    Point p4 = pentagon.points[3];
    Point p5 = pentagon.points[4];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p51 = Point.interpolate(p5, p1, 0.5);
    result.addTriangle(p34, p51, p1);
    result.addTriangle(p34, p1, p12);
    result.addTriangle(p34, p5, p51);
    result.addTriangle(p34, p12, p2);
    result.addTriangle(p34, p4, p5);
    result.addTriangle(p34, p2, p3);
    return result;
  }
}

static class P07 implements PentagonSubdivision {
  SubdivisionResult apply(final Pentagon pentagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = pentagon.points[0];
    Point p2 = pentagon.points[1];
    Point p3 = pentagon.points[2];
    Point p4 = pentagon.points[3];
    Point p5 = pentagon.points[4];
    Point q = pentagon.centroid();
    result.addTriangle(q, p3, p4);
    result.addTriangle(q, p4, p5);
    result.addTriangle(q, p5, p1);
    result.addTriangle(q, p1, p2);
    result.addTriangle(q, p2, p3);
    return result;
  }
}

static class P08 implements PentagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Pentagon pentagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = pentagon.points[0];
    Point p2 = pentagon.points[1];
    Point p3 = pentagon.points[2];
    Point p4 = pentagon.points[3];
    Point p5 = pentagon.points[4];
    Point q = pentagon.centroid();
    Point q1 = Point.interpolate(p1, q, f);
    Point q2 = Point.interpolate(p2, q, f);
    Point q3 = Point.interpolate(p3, q, f);
    Point q4 = Point.interpolate(p4, q, f);
    Point q5 = Point.interpolate(p5, q, f);
    result.addQuad(p3, p4, q4, q3);
    result.addQuad(p4, p5, q5, q4);
    result.addQuad(p5, p1, q1, q5);
    result.addQuad(p1, p2, q2, q1);
    result.addQuad(p2, p3, q3, q2);
    result.addPentagon(q1, q2, q3, q4, q5);
    return result;
  }

  P08 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class P09 implements PentagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Pentagon pentagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = pentagon.points[0];
    Point p2 = pentagon.points[1];
    Point p3 = pentagon.points[2];
    Point p4 = pentagon.points[3];
    Point p5 = pentagon.points[4];
    Point q = pentagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p51 = Point.interpolate(p5, p1, 0.5);
    Point.interpolate(p1, q, f);
    Point.interpolate(p2, q, f);
    Point.interpolate(p3, q, f);
    Point.interpolate(p4, q, f);
    Point.interpolate(p5, q, f);
    Point q12 = Point.interpolate(p12, q, f);
    Point q23 = Point.interpolate(p23, q, f);
    Point q34 = Point.interpolate(p34, q, f);
    Point q45 = Point.interpolate(p45, q, f);
    Point q51 = Point.interpolate(p51, q, f);
    result.addQuad(p1, q12, q, q51);
    result.addQuad(p2, q23, q, q12);
    result.addQuad(p3, q34, q, q23);
    result.addQuad(p4, q45, q, q34);
    result.addQuad(p5, q51, q, q45);
    result.addTriangle(q51, p5, p1);
    result.addTriangle(q12, p1, p2);
    result.addTriangle(q23, p2, p3);
    result.addTriangle(q34, p3, p4);
    result.addTriangle(q45, p4, p5);
    return result;
  }

  P09 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class P10 implements PentagonSubdivision {
  SubdivisionResult apply(final Pentagon pentagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = pentagon.points[0];
    Point p2 = pentagon.points[1];
    Point p3 = pentagon.points[2];
    Point p4 = pentagon.points[3];
    Point p5 = pentagon.points[4];
    result.addQuad(p2, p3, p4, p5);
    result.addTriangle(p1, p2, p5);
    return result;
  }
}

static class P11 implements PentagonSubdivision {
  SubdivisionResult apply(final Pentagon pentagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = pentagon.points[0];
    Point p2 = pentagon.points[1];
    Point p3 = pentagon.points[2];
    Point p4 = pentagon.points[3];
    Point p5 = pentagon.points[4];
    result.addTriangle(p1, p2, p3);
    result.addTriangle(p1, p3, p4);
    result.addTriangle(p1, p4, p5);
    return result;
  }
}

interface HexagonSubdivision {
  SubdivisionResult apply(Hexagon hexagon);
}

static class H01 implements HexagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Hexagon hexagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = hexagon.points[0];
    Point p2 = hexagon.points[1];
    Point p3 = hexagon.points[2];
    Point p4 = hexagon.points[3];
    Point p5 = hexagon.points[4];
    Point p6 = hexagon.points[5];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p61 = Point.interpolate(p6, p1, 0.5);
    Point q = hexagon.centroid();
    Point q12 = Point.interpolate(p12, q, f);
    Point q23 = Point.interpolate(p23, q, f);
    Point q34 = Point.interpolate(p34, q, f);
    Point q45 = Point.interpolate(p45, q, f);
    Point q56 = Point.interpolate(p56, q, f);
    Point q61 = Point.interpolate(p61, q, f);
    result.addPentagon(p1, p12, q12, q61, p61);
    result.addPentagon(p2, p23, q23, q12, p12);
    result.addPentagon(p3, p34, q34, q23, p23);
    result.addPentagon(p4, p45, q45, q34, p34);
    result.addPentagon(p5, p56, q56, q45, p45);
    result.addPentagon(p6, p61, q61, q56, p56);
    result.addHexagon(q56, q61, q12, q23, q34, q45);
    return result;
  }

  H01 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class H02 implements HexagonSubdivision {
  SubdivisionResult apply(final Hexagon hexagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = hexagon.points[0];
    Point p2 = hexagon.points[1];
    Point p3 = hexagon.points[2];
    Point p4 = hexagon.points[3];
    Point p5 = hexagon.points[4];
    Point p6 = hexagon.points[5];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p61 = Point.interpolate(p6, p1, 0.5);
    Point q = hexagon.centroid();
    result.addQuad(p1, p12, q, p61);
    result.addQuad(p2, p23, q, p12);
    result.addQuad(p3, p34, q, p23);
    result.addQuad(p4, p45, q, p34);
    result.addQuad(p5, p56, q, p45);
    result.addQuad(p6, p61, q, p56);
    return result;
  }
}

static class H03 implements HexagonSubdivision {
  SubdivisionResult apply(final Hexagon hexagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = hexagon.points[0];
    Point p2 = hexagon.points[1];
    Point p3 = hexagon.points[2];
    Point p4 = hexagon.points[3];
    Point p5 = hexagon.points[4];
    Point p6 = hexagon.points[5];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p61 = Point.interpolate(p6, p1, 0.5);
    result.addTriangle(p1, p12, p61);
    result.addTriangle(p2, p23, p12);
    result.addTriangle(p3, p34, p23);
    result.addTriangle(p4, p45, p34);
    result.addTriangle(p5, p56, p45);
    result.addTriangle(p6, p61, p56);
    result.addHexagon(p56, p61, p12, p23, p34, p45);
    return result;
  }
}

static class H04 implements HexagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Hexagon hexagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = hexagon.points[5];
    Point p2 = hexagon.points[0];
    Point p3 = hexagon.points[1];
    Point p4 = hexagon.points[2];
    Point p5 = hexagon.points[3];
    Point p6 = hexagon.points[4];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p61 = Point.interpolate(p6, p1, 0.5);
    Point q = hexagon.centroid();
    Point q1 = Point.interpolate(p1, q, f);
    Point q2 = Point.interpolate(p2, q, f);
    Point q3 = Point.interpolate(p3, q, f);
    Point q4 = Point.interpolate(p4, q, f);
    Point q5 = Point.interpolate(p5, q, f);
    Point q6 = Point.interpolate(p6, q, f);
    result.addQuad(p1, p12, q1, p61);
    result.addQuad(p2, p23, q2, p12);
    result.addQuad(p3, p34, q3, p23);
    result.addQuad(p4, p45, q4, p34);
    result.addQuad(p5, p56, q5, p45);
    result.addQuad(p6, p61, q6, p56);
    result.addQuad(p61, q1, q, q6);
    result.addQuad(p12, q2, q, q1);
    result.addQuad(p23, q3, q, q2);
    result.addQuad(p34, q4, q, q3);
    result.addQuad(p45, q5, q, q4);
    result.addQuad(p56, q6, q, q5);
    return result;
  }

  H04 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class H05 implements HexagonSubdivision {
  SubdivisionResult apply(final Hexagon hexagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = hexagon.points[0];
    Point p2 = hexagon.points[1];
    Point p3 = hexagon.points[2];
    Point p4 = hexagon.points[3];
    Point p5 = hexagon.points[4];
    Point p6 = hexagon.points[5];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point q = hexagon.centroid();
    result.addPentagon(q, p12, p2, p3, p34);
    result.addPentagon(q, p34, p4, p5, p56);
    result.addPentagon(q, p56, p6, p1, p12);
    return result;
  }
}

static class H06 implements HexagonSubdivision {
  SubdivisionResult apply(final Hexagon hexagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = hexagon.points[0];
    Point p2 = hexagon.points[1];
    Point p3 = hexagon.points[2];
    Point p4 = hexagon.points[3];
    Point p5 = hexagon.points[4];
    Point p6 = hexagon.points[5];
    Point q = hexagon.centroid();
    result.addTriangle(q, p6, p1);
    result.addTriangle(q, p1, p2);
    result.addTriangle(q, p2, p3);
    result.addTriangle(q, p3, p4);
    result.addTriangle(q, p4, p5);
    result.addTriangle(q, p5, p6);
    return result;
  }
}

static class H07 implements HexagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Hexagon hexagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = hexagon.points[0];
    Point p2 = hexagon.points[1];
    Point p3 = hexagon.points[2];
    Point p4 = hexagon.points[3];
    Point p5 = hexagon.points[4];
    Point p6 = hexagon.points[5];
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p61 = Point.interpolate(p6, p1, 0.5);
    Point q = hexagon.centroid();
    Point q1 = Point.interpolate(p1, q, f);
    Point q2 = Point.interpolate(p2, q, f);
    Point q3 = Point.interpolate(p3, q, f);
    Point q4 = Point.interpolate(p4, q, f);
    Point q5 = Point.interpolate(p5, q, f);
    Point q6 = Point.interpolate(p6, q, f);
    result.addQuad(p1, p12, q1, p61);
    result.addQuad(p2, p23, q2, p12);
    result.addQuad(p3, p34, q3, p23);
    result.addQuad(p4, p45, q4, p34);
    result.addQuad(p5, p56, q5, p45);
    result.addQuad(p6, p61, q6, p56);
    result.addQuad(p61, q1, q, q6);
    result.addQuad(p12, q2, q, q1);
    result.addQuad(p23, q3, q, q2);
    result.addQuad(p34, q4, q, q3);
    result.addQuad(p45, q5, q, q4);
    result.addQuad(p56, q6, q, q5);
    return result;
  }

  H07 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class H08 implements HexagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Hexagon hexagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = hexagon.points[0];
    Point p2 = hexagon.points[1];
    Point p3 = hexagon.points[2];
    Point p4 = hexagon.points[3];
    Point p5 = hexagon.points[4];
    Point p6 = hexagon.points[5];
    Point q = hexagon.centroid();
    Point q1 = Point.interpolate(p1, q, f);
    Point q2 = Point.interpolate(p2, q, f);
    Point q3 = Point.interpolate(p3, q, f);
    Point q4 = Point.interpolate(p4, q, f);
    Point q5 = Point.interpolate(p5, q, f);
    Point q6 = Point.interpolate(p6, q, f);
    result.addQuad(p6, p1, q1, q6);
    result.addQuad(p1, p2, q2, q1);
    result.addQuad(p2, p3, q3, q2);
    result.addQuad(p3, p4, q4, q3);
    result.addQuad(p4, p5, q5, q4);
    result.addQuad(p5, p6, q6, q5);
    result.addHexagon(q1, q2, q3, q4, q5, q6);
    return result;
  }

  H08 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class H09 implements HexagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Hexagon hexagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = hexagon.points[0];
    Point p2 = hexagon.points[1];
    Point p3 = hexagon.points[2];
    Point p4 = hexagon.points[3];
    Point p5 = hexagon.points[4];
    Point p6 = hexagon.points[5];
    Point q = hexagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p61 = Point.interpolate(p6, p1, 0.5);
    Point q12 = Point.interpolate(p12, q, f);
    Point q23 = Point.interpolate(p23, q, f);
    Point q34 = Point.interpolate(p34, q, f);
    Point q45 = Point.interpolate(p45, q, f);
    Point q56 = Point.interpolate(p56, q, f);
    Point q61 = Point.interpolate(p61, q, f);
    result.addQuad(p1, q12, q, q61);
    result.addQuad(p2, q23, q, q12);
    result.addQuad(p3, q34, q, q23);
    result.addQuad(p4, q45, q, q34);
    result.addQuad(p5, q56, q, q45);
    result.addQuad(p6, q61, q, q56);
    result.addTriangle(q61, p6, p1);
    result.addTriangle(q12, p1, p2);
    result.addTriangle(q23, p2, p3);
    result.addTriangle(q34, p3, p4);
    result.addTriangle(q45, p4, p5);
    result.addTriangle(q56, p5, p6);
    return result;
  }

  H09 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class H10 implements HexagonSubdivision {
  SubdivisionResult apply(final Hexagon hexagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = hexagon.points[0];
    Point p2 = hexagon.points[1];
    Point p3 = hexagon.points[2];
    Point p4 = hexagon.points[3];
    Point p5 = hexagon.points[4];
    Point p6 = hexagon.points[5];
    result.addQuad(p2, p3, p5, p6);
    result.addTriangle(p1, p2, p6);
    result.addTriangle(p3, p4, p5);
    return result;
  }
}

static class H11 implements HexagonSubdivision {
  SubdivisionResult apply(final Hexagon hexagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = hexagon.points[0];
    Point p2 = hexagon.points[1];
    Point p3 = hexagon.points[2];
    Point p4 = hexagon.points[3];
    Point p5 = hexagon.points[4];
    Point p6 = hexagon.points[5];
    result.addQuad(p1, p2, p3, p4);
    result.addQuad(p1, p4, p5, p6);
    return result;
  }
}

interface OctagonSubdivision {
  SubdivisionResult apply(Octagon octagon);
}

static class O01 implements OctagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p67 = Point.interpolate(p6, p7, 0.5);
    Point p81 = Point.interpolate(p8, p1, 0.5);
    Point q23 = Point.interpolate(p23, q, f);
    Point q45 = Point.interpolate(p45, q, f);
    Point q67 = Point.interpolate(p67, q, f);
    Point q81 = Point.interpolate(p81, q, f);
    result.addQuad(p1, p2, q23, q81);
    result.addQuad(p3, p4, q45, q23);
    result.addQuad(p5, p6, q67, q45);
    result.addQuad(p7, p8, q81, q67);
    result.addTriangle(q81, p8, p1);
    result.addTriangle(q23, p2, p3);
    result.addTriangle(q45, p4, p5);
    result.addTriangle(q67, p6, p7);
    result.addQuad(q81, q23, q45, q67);
    return result;
  }

  O01 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class O02 implements OctagonSubdivision {
  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p78 = Point.interpolate(p7, p8, 0.5);
    result.addPentagon(q, p78, p8, p1, p12);
    result.addPentagon(q, p12, p2, p3, p34);
    result.addPentagon(q, p34, p4, p5, p56);
    result.addPentagon(q, p56, p6, p7, p78);
    return result;
  }
}

static class O03 implements OctagonSubdivision {
  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    result.addTriangle(q, p8, p1);
    result.addTriangle(q, p1, p2);
    result.addTriangle(q, p2, p3);
    result.addTriangle(q, p3, p4);
    result.addTriangle(q, p4, p5);
    result.addTriangle(q, p5, p6);
    result.addTriangle(q, p6, p7);
    result.addTriangle(q, p7, p8);
    return result;
  }
}

static class O04 implements OctagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p67 = Point.interpolate(p6, p7, 0.5);
    Point p78 = Point.interpolate(p7, p8, 0.5);
    Point p81 = Point.interpolate(p8, p1, 0.5);
    Point q12 = Point.interpolate(p12, q, f);
    Point q23 = Point.interpolate(p23, q, f);
    Point q34 = Point.interpolate(p34, q, f);
    Point q45 = Point.interpolate(p45, q, f);
    Point q56 = Point.interpolate(p56, q, f);
    Point q67 = Point.interpolate(p67, q, f);
    Point q78 = Point.interpolate(p78, q, f);
    Point q81 = Point.interpolate(p81, q, f);
    result.addQuad(p1, q12, q, q81);
    result.addQuad(p2, q23, q, q12);
    result.addQuad(p3, q34, q, q23);
    result.addQuad(p4, q45, q, q34);
    result.addQuad(p5, q56, q, q45);
    result.addQuad(p6, q67, q, q56);
    result.addQuad(p7, q78, q, q67);
    result.addQuad(p8, q81, q, q78);
    result.addTriangle(q81, p8, p1);
    result.addTriangle(q12, p1, p2);
    result.addTriangle(q23, p2, p3);
    result.addTriangle(q34, p3, p4);
    result.addTriangle(q45, p4, p5);
    result.addTriangle(q56, p5, p6);
    result.addTriangle(q67, p6, p7);
    result.addTriangle(q78, p7, p8);
    return result;
  }

  O04 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class O05 implements OctagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p67 = Point.interpolate(p6, p7, 0.5);
    Point p78 = Point.interpolate(p7, p8, 0.5);
    Point p81 = Point.interpolate(p8, p1, 0.5);
    Point q1 = Point.interpolate(p1, q, f);
    Point q2 = Point.interpolate(p2, q, f);
    Point q3 = Point.interpolate(p3, q, f);
    Point q4 = Point.interpolate(p4, q, f);
    Point q5 = Point.interpolate(p5, q, f);
    Point q6 = Point.interpolate(p6, q, f);
    Point q7 = Point.interpolate(p7, q, f);
    Point q8 = Point.interpolate(p8, q, f);
    result.addQuad(p1, p12, q1, p81);
    result.addQuad(p2, p23, q2, p12);
    result.addQuad(p3, p34, q3, p23);
    result.addQuad(p4, p45, q4, p34);
    result.addQuad(p5, p56, q5, p45);
    result.addQuad(p6, p67, q6, p56);
    result.addQuad(p7, p78, q7, p67);
    result.addQuad(p8, p81, q8, p78);
    result.addQuad(p81, q1, q, q8);
    result.addQuad(p12, q2, q, q1);
    result.addQuad(p23, q3, q, q2);
    result.addQuad(p34, q4, q, q3);
    result.addQuad(p45, q5, q, q4);
    result.addQuad(p56, q6, q, q5);
    result.addQuad(p67, q7, q, q6);
    result.addQuad(p78, q8, q, q7);
    return result;
  }

  O05 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class O06 implements OctagonSubdivision {
  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p67 = Point.interpolate(p6, p7, 0.5);
    Point p78 = Point.interpolate(p7, p8, 0.5);
    Point p81 = Point.interpolate(p8, p1, 0.5);
    result.addQuad(p1, p12, q, p81);
    result.addQuad(p2, p23, q, p12);
    result.addQuad(p3, p34, q, p23);
    result.addQuad(p4, p45, q, p34);
    result.addQuad(p5, p56, q, p45);
    result.addQuad(p6, p67, q, p56);
    result.addQuad(p7, p78, q, p67);
    result.addQuad(p8, p81, q, p78);
    return result;
  }
}

static class O07 implements OctagonSubdivision {
  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p67 = Point.interpolate(p6, p7, 0.5);
    Point p78 = Point.interpolate(p7, p8, 0.5);
    Point p81 = Point.interpolate(p8, p1, 0.5);
    result.addTriangle(p1, p12, p81);
    result.addTriangle(p2, p23, p12);
    result.addTriangle(p3, p34, p23);
    result.addTriangle(p4, p45, p34);
    result.addTriangle(p5, p56, p45);
    result.addTriangle(p6, p67, p56);
    result.addTriangle(p7, p78, p67);
    result.addTriangle(p8, p81, p78);
    result.addTriangle(q, p12, p81);
    result.addTriangle(q, p23, p12);
    result.addTriangle(q, p34, p23);
    result.addTriangle(q, p45, p34);
    result.addTriangle(q, p56, p45);
    result.addTriangle(q, p67, p56);
    result.addTriangle(q, p78, p67);
    result.addTriangle(q, p81, p78);
    return result;
  }
}

static class O08 implements OctagonSubdivision {
  private float f = 0.5;


  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p78 = Point.interpolate(p7, p8, 0.5);
    Point q12 = Point.interpolate(p12, q, f);
    Point q34 = Point.interpolate(p34, q, f);
    Point q56 = Point.interpolate(p56, q, f);
    Point q78 = Point.interpolate(p78, q, f);
    result.addTriangle(q, p8, p1);
    result.addTriangle(q, p2, p3);
    result.addTriangle(q, p4, p5);
    result.addTriangle(q, p6, p7);
    result.addTriangle(q12, p1, p2);
    result.addTriangle(q, p1, q12);
    result.addTriangle(q, q12, p2);
    result.addTriangle(q34, p3, p4);
    result.addTriangle(q, p3, q34);
    result.addTriangle(q, q34, p4);
    result.addTriangle(q56, p5, p6);
    result.addTriangle(q, p5, q56);
    result.addTriangle(q, q56, p6);
    result.addTriangle(q78, p7, p8);
    result.addTriangle(q, p7, q78);
    result.addTriangle(q, q78, p8);
    return result;
  }

  O08 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class O09 implements OctagonSubdivision {
  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p67 = Point.interpolate(p6, p7, 0.5);
    Point p78 = Point.interpolate(p7, p8, 0.5);
    Point p81 = Point.interpolate(p8, p1, 0.5);
    result.addTriangle(p1, p12, p81);
    result.addTriangle(p2, p23, p12);
    result.addTriangle(p3, p34, p23);
    result.addTriangle(p4, p45, p34);
    result.addTriangle(p5, p56, p45);
    result.addTriangle(p6, p67, p56);
    result.addTriangle(p7, p78, p67);
    result.addTriangle(p8, p81, p78);
    result.addQuad(q, p81, p12, p23);
    result.addQuad(q, p23, p34, p45);
    result.addQuad(q, p45, p56, p67);
    result.addQuad(q, p67, p78, p81);
    return result;
  }
}

static class O10 implements OctagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p67 = Point.interpolate(p6, p7, 0.5);
    Point p78 = Point.interpolate(p7, p8, 0.5);
    Point p81 = Point.interpolate(p8, p1, 0.5);
    Point q1 = Point.interpolate(p1, q, f);
    Point q2 = Point.interpolate(p2, q, f);
    Point q3 = Point.interpolate(p3, q, f);
    Point q4 = Point.interpolate(p4, q, f);
    Point q5 = Point.interpolate(p5, q, f);
    Point q6 = Point.interpolate(p6, q, f);
    Point q7 = Point.interpolate(p7, q, f);
    Point q8 = Point.interpolate(p8, q, f);
    Point.interpolate(p12, q, f);
    Point.interpolate(p23, q, f);
    Point.interpolate(p34, q, f);
    Point.interpolate(p45, q, f);
    Point.interpolate(p56, q, f);
    Point.interpolate(p67, q, f);
    Point.interpolate(p78, q, f);
    Point.interpolate(p81, q, f);
    result.addQuad(p8, p1, q1, q8);
    result.addQuad(p1, p2, q2, q1);
    result.addQuad(p2, p3, q3, q2);
    result.addQuad(p3, p4, q4, q3);
    result.addQuad(p4, p5, q5, q4);
    result.addQuad(p5, p6, q6, q5);
    result.addQuad(p6, p7, q7, q6);
    result.addQuad(p7, p8, q8, q7);
    result.addOctagon(q1, q2, q3, q4, q5, q6, q7, q8);
    return result;
  }

  O10 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class O11 implements OctagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p67 = Point.interpolate(p6, p7, 0.5);
    Point p78 = Point.interpolate(p7, p8, 0.5);
    Point p81 = Point.interpolate(p8, p1, 0.5);
    Point q12 = Point.interpolate(p12, q, f);
    Point q23 = Point.interpolate(p23, q, f);
    Point q34 = Point.interpolate(p34, q, f);
    Point q45 = Point.interpolate(p45, q, f);
    Point q56 = Point.interpolate(p56, q, f);
    Point q67 = Point.interpolate(p67, q, f);
    Point q78 = Point.interpolate(p78, q, f);
    Point q81 = Point.interpolate(p81, q, f);
    result.addPentagon(p1, p12, q12, q81, p81);
    result.addPentagon(p2, p23, q23, q12, p12);
    result.addPentagon(p3, p34, q34, q23, p23);
    result.addPentagon(p4, p45, q45, q34, p34);
    result.addPentagon(p5, p56, q56, q45, p45);
    result.addPentagon(p6, p67, q67, q56, p56);
    result.addPentagon(p7, p78, q78, q67, p67);
    result.addPentagon(p8, p81, q81, q78, p78);
    result.addOctagon(q81, q12, q23, q34, q45, q56, q67, q78);
    return result;
  }

  O11 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class O12 implements OctagonSubdivision {
  private float f = 0.5;


  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p23 = Point.interpolate(p2, p3, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p45 = Point.interpolate(p4, p5, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p67 = Point.interpolate(p6, p7, 0.5);
    Point p78 = Point.interpolate(p7, p8, 0.5);
    Point p81 = Point.interpolate(p8, p1, 0.5);
    Point q12 = Point.interpolate(p12, q, f);
    Point q34 = Point.interpolate(p34, q, f);
    Point q56 = Point.interpolate(p56, q, f);
    Point q78 = Point.interpolate(p78, q, f);
    result.addPentagon(q12, p81, p1, p2, p23);
    result.addPentagon(q34, p23, p3, p4, p45);
    result.addPentagon(q56, p45, p5, p6, p67);
    result.addPentagon(q78, p67, p7, p8, p81);
    result.addQuad(q, q78, p81, q12);
    result.addQuad(q, q12, p23, q34);
    result.addQuad(q, q34, p45, q56);
    result.addQuad(q, q56, p67, q78);
    return result;
  }

  O12 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class O13 implements OctagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p78 = Point.interpolate(p7, p8, 0.5);
    Point q12 = Point.interpolate(p12, q, f);
    Point q34 = Point.interpolate(p34, q, f);
    Point q56 = Point.interpolate(p56, q, f);
    Point q78 = Point.interpolate(p78, q, f);
    result.addPentagon(q, q78, p8, p1, q12);
    result.addPentagon(q, q12, p2, p3, q34);
    result.addPentagon(q, q34, p4, p5, q56);
    result.addPentagon(q, q56, p6, p7, q78);
    result.addTriangle(q12, p1, p2);
    result.addTriangle(q34, p3, p4);
    result.addTriangle(q56, p5, p6);
    result.addTriangle(q78, p7, p8);
    return result;
  }

  O13 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}

static class O14 implements OctagonSubdivision {
  private float f = 0.5;
  SubdivisionResult apply(final Octagon octagon) {
    SubdivisionResult result = new SubdivisionResult();
    Point p1 = octagon.points[0];
    Point p2 = octagon.points[1];
    Point p3 = octagon.points[2];
    Point p4 = octagon.points[3];
    Point p5 = octagon.points[4];
    Point p6 = octagon.points[5];
    Point p7 = octagon.points[6];
    Point p8 = octagon.points[7];
    Point q = octagon.centroid();
    Point p12 = Point.interpolate(p1, p2, 0.5);
    Point p34 = Point.interpolate(p3, p4, 0.5);
    Point p56 = Point.interpolate(p5, p6, 0.5);
    Point p78 = Point.interpolate(p7, p8, 0.5);
    Point q12 = Point.interpolate(p12, q, f);
    Point q34 = Point.interpolate(p34, q, f);
    Point q56 = Point.interpolate(p56, q, f);
    Point q78 = Point.interpolate(p78, q, f);
    result.addQuad(p8, p1, q12, q78);
    result.addQuad(p2, p3, q34, q12);
    result.addQuad(p4, p5, q56, q34);
    result.addQuad(p6, p7, q78, q56);
    result.addTriangle(q12, p1, p2);
    result.addTriangle(q34, p3, p4);
    result.addTriangle(q56, p5, p6);
    result.addTriangle(q78, p7, p8);
    result.addTriangle(q, q78, q12);
    result.addTriangle(q, q12, q34);
    result.addTriangle(q, q34, q56);
    result.addTriangle(q, q56, q78);
    return result;
  }

  O14 setF(final float ff) {
    if (ff > 0 && ff < 1.0) {
      f = ff;
    } else {
      f = 0.5;
    }
    return this;
  }
}


static class SubdivisionResult {
  ArrayList<Triangle> triangles;
  ArrayList<Quad> quads;
  ArrayList<Pentagon> pentagons;
  ArrayList<Hexagon> hexagons;
  ArrayList<Octagon> octagons;

  SubdivisionResult() {
    triangles = new ArrayList<Triangle>();
    quads = new ArrayList<Quad>();
    pentagons = new ArrayList<Pentagon>();
    hexagons = new ArrayList<Hexagon>();
    octagons = new ArrayList<Octagon>();
  }

  void addTriangle(Triangle triangle) {
    triangles.add(triangle);
  }

  void addQuad(Quad quad) {
    if (quad.isConvex()) {
      quads.add(quad);
    } else {
      boolean p0inside = quad.points[0].inTriangle(quad.points[1], quad.points[2], quad.points[3]);
      boolean p2inside = quad.points[2].inTriangle(quad.points[0], quad.points[1], quad.points[3]);
      if (p0inside || p2inside) {
        addTriangle(quad.points[0], quad.points[1], quad.points[2]);
        addTriangle(quad.points[0], quad.points[2], quad.points[3]);
      } else {
        addTriangle(quad.points[0], quad.points[1], quad.points[3]);
        addTriangle(quad.points[1], quad.points[2], quad.points[3]);
      }
    }
  }

  void addPentagon(Pentagon pentagon) {
    pentagons.add(pentagon);
  }

  void addHexagon(Hexagon hexagon) {
    hexagons.add(hexagon);
  }

  void addOctagon(Octagon octagon) {
    octagons.add(octagon);
  }

  void addTriangle(Point... points) {
    triangles.add(new Triangle(points));
  }

  void addQuad(Point... points) {
    Quad quad = new Quad(points);
    addQuad(quad);
  }

  void addPentagon(Point... points) {
    pentagons.add(new Pentagon(points));
  }

  void addHexagon(Point... points) {
    hexagons.add(new Hexagon(points));
  }

  void addOctagon(Point... points) {
    octagons.add(new Octagon(points));
  }

  ArrayList<Triangle> getTriangles() {
    return triangles;
  }

  ArrayList<Quad> getQuads() {
    return quads;
  }

  ArrayList<Pentagon> getPentagons() {
    return pentagons;
  }

  ArrayList<Hexagon> getHexagons() {
    return hexagons;
  }

  ArrayList<Octagon> getOctagons() {
    return octagons;
  }
}

static SubdivisionResult subdivide(final Triangle triangle, final TriangleSubdivision rule) {
  return rule.apply(triangle);
}

static SubdivisionResult subdivide(final Quad quad, final QuadSubdivision rule) {
  return rule.apply(quad);
}

static SubdivisionResult subdivide(final Pentagon pentagon, final PentagonSubdivision rule) {
  return rule.apply(pentagon);
}

static SubdivisionResult subdivide(final Hexagon hexagon, final HexagonSubdivision rule) {
  return rule.apply(hexagon);
}

static SubdivisionResult subdivide(final Octagon octagon, final OctagonSubdivision rule) {
  return rule.apply(octagon);
}
