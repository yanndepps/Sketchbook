Triangle startTriangle;
Quad startQuad;
Pentagon startPentagon;
Hexagon startHexagon;
Octagon startOctagon;
Polygon perimeter;
ArrayList<Triangle> allTriangles=new ArrayList<Triangle>();
ArrayList<Quad> allQuads=new ArrayList<Quad>();
ArrayList<Pentagon> allPentagons=new ArrayList<Pentagon>();
ArrayList<Hexagon> allHexagons=new ArrayList<Hexagon>();
ArrayList<Octagon> allOctagons=new ArrayList<Octagon>();
SubdivisionResult result;
float L;
int REP, MAXREP;
void setup() {
  fullScreen();
  smooth(16);
  noCursor();
  L=540.0;
  REP=1;
  MAXREP=6;
  createStart();
  textSize(16);
}

void createStart() {
  startTriangle=new Triangle(new Point(0, +0.75*L), new Point(-cos(PI/6)*L, -0.75*L), new Point(+cos(PI/6)*L, -0.75*L));
  startQuad=new Quad(new Point(-0.8*L, -0.8*L), new Point(+0.8*L, -0.8*L), new Point(+0.8*L, +0.8*L), new Point(-0.8*L, +0.8*L));
  float c1=0.9*L*(float)(0.25*(Math.sqrt(5.0)-1.0));
  float c2=0.9*L*(float)(0.25*(Math.sqrt(5.0)+1.0));
  float s1=0.9*L*(float)(0.25*Math.sqrt(10.0+2*Math.sqrt(5.0)));
  float s2=0.9*L*(float)(0.25*Math.sqrt(10.0-2*Math.sqrt(5.0)));
  startPentagon=new Pentagon(new Point(0, -0.5*(L+c2)), new Point(+s1, -c1+0.5*(L-c2)), new Point(+s2, 0.5*(L+c2)), new Point(-s2, 0.5*(L+c2)), new Point(-s1, -c1+0.5*(L-c2)));
  float a=0.4*L;
  float b=(float)(0.4*L*Math.sqrt(3.0));
  startHexagon=new Hexagon(new Point( +2*a,0), new Point(a,b), new Point(-a,b), new Point(-2*a,0), new Point( -a,-b), new Point(a,-b));
  startOctagon=new Octagon(new Point(-0.4*L, +0.8*L), new Point(+0.4*L, +0.8*L), new Point(+0.8*L, +0.4*L), new Point(+0.8*L, -0.4*L), new Point(+0.4*L, -0.8*L), new Point(-0.4*L, -0.8*L), new Point(-0.8*L, -0.4*L), new Point(-0.8*L, +0.4*L));
}

void draw() {
  background(0);
  create();
  translate(width/2,height/2);
  rotateZ(random(100)<50?0:PI);
  noFill();
  stroke(255,200);
  perimeter.draw(this);
  for (Triangle triangle : allTriangles) {
    triangle.draw(this);
  }
  for (Quad quad : allQuads) {
    quad.draw(this);
  }
  for (Pentagon pentagon : allPentagons) {
    pentagon.draw(this);
  }
  for (Hexagon hexagon : allHexagons) {
    hexagon.draw(this);
  }
  for (Octagon octagon : allOctagons) {
    octagon.draw(this);
  }
  noLoop();
}

void create() {
  allTriangles.clear();
  allQuads.clear();
  allPentagons.clear();
  allHexagons.clear();
  allOctagons.clear();
  
    switch((int)random(5)) {
    case 0:
      startWithTriangle();
      break;
    case 1:
      startWithQuad();
      break;
    case 2:
      startWithPentagon();
      break;
    case 3:
      startWithHexagon();
      break;
    case 4:
      startWithOctagon();
      break;
    }
    for (int i=0; i<REP; i++) {
      subdivide(i);
    }
    text( "+/-: increase/decrease iterations", 50, 90+20*REP);
    text( "left click: reset", 50, 110+20*REP);
    println();
  
}

void startWithTriangle() {
  allTriangles.add(startTriangle);
  perimeter=startTriangle;
  text("T("+REP+") (+/-)",50,50);
  println("T("+REP+") (+/-)");
  
}

void startWithQuad() {
  allQuads.add(startQuad);
  perimeter=startQuad;
  text("Q("+REP+")",50,50);
  println("Q("+REP+")");
}

void startWithPentagon() {
  allPentagons.add(startPentagon);
  perimeter=startPentagon;
  text("P("+REP+")",50,50);
  println("P("+REP+")");
}

void startWithHexagon() {
  allHexagons.add(startHexagon);
  perimeter=startHexagon;
  text("H("+REP+")",50,50);
  println("H("+REP+")");
}

void startWithOctagon() {
  allOctagons.add(startOctagon);
  perimeter=startOctagon;
  text("O("+REP+")",50,50);
  println("O("+REP+")");
}


void subdivide(int r) {
  ArrayList<Triangle> triangles=new ArrayList<Triangle>();
  triangles.addAll(allTriangles);
  ArrayList<Quad> quads=new ArrayList<Quad>();
  quads.addAll(allQuads);
  ArrayList<Pentagon> pentagons=new ArrayList<Pentagon>();
  pentagons.addAll(allPentagons);
  ArrayList<Hexagon> hexagons=new ArrayList<Hexagon>();
  hexagons.addAll(allHexagons);
  ArrayList<Octagon> octagons=new ArrayList<Octagon>();
  octagons.addAll(allOctagons);

  int T=(triangles.size()>0)?(int)random(TSubs.length):-1;
  int Q=(quads.size()>0)?(int)random(QSubs.length):-1;
  int P=(pentagons.size()>0)?(int)random(PSubs.length):-1;
  int H=(hexagons.size()>0)?(int)random(HSubs.length):-1;
  int O=(octagons.size()>0)?(int)random(OSubs.length):-1;

  boolean concave = false;
  do {
    allTriangles.clear();
    allQuads.clear();
    allPentagons.clear();
    allHexagons.clear();
    allOctagons.clear();
    if (concave) {
      Q=(int)random(QSubs.length);
      concave=false;
    }
    for (Quad quad : quads) {
      SubdivisionResult subresult=subdivide(quad, QSubs[Q]);
      for (Quad q : subresult.getQuads()) {
        if (!q.isConvex()) {
          concave=true;
          break;
        }
      }
      allTriangles.addAll(subresult.getTriangles());
      allQuads.addAll(subresult.getQuads());
      allPentagons.addAll(subresult.getPentagons());
      allHexagons.addAll(subresult.getHexagons());
      allOctagons.addAll(subresult.getOctagons());
    }
  } while (concave);

  for (Triangle triangle : triangles) {
    SubdivisionResult subresult=subdivide(triangle, TSubs[T]);
    allTriangles.addAll(subresult.getTriangles());
    allQuads.addAll(subresult.getQuads());
    allPentagons.addAll(subresult.getPentagons());
    allHexagons.addAll(subresult.getHexagons());
    allOctagons.addAll(subresult.getOctagons());
  }

  for (Pentagon pentagon : pentagons) {
    SubdivisionResult subresult=subdivide(pentagon, PSubs[P]);
    allTriangles.addAll(subresult.getTriangles());
    allQuads.addAll(subresult.getQuads());
    allPentagons.addAll(subresult.getPentagons());
    allHexagons.addAll(subresult.getHexagons());
    allOctagons.addAll(subresult.getOctagons());
  }
  for (Hexagon hexagon : hexagons) {
    SubdivisionResult subresult=subdivide(hexagon, HSubs[H]);
    allTriangles.addAll(subresult.getTriangles());
    allQuads.addAll(subresult.getQuads());
    allPentagons.addAll(subresult.getPentagons());
    allHexagons.addAll(subresult.getHexagons());
    allOctagons.addAll(subresult.getOctagons());
  }

  for (Octagon octagon : octagons) {
    SubdivisionResult subresult=subdivide(octagon, OSubs[O]);
    allTriangles.addAll(subresult.getTriangles());
    allQuads.addAll(subresult.getQuads());
    allPentagons.addAll(subresult.getPentagons());
    allHexagons.addAll(subresult.getHexagons());
    allOctagons.addAll(subresult.getOctagons());
  }
  text( "  "+((T>=0)?"T"+str(T):"T_")+" "+((Q>=0)?"Q"+str(Q):"Q_")+" "+((P>=0)?"P"+str(P):"P_")+" "+((H>=0)?"H"+str(H):"H_")+" "+((O>=0)?"O"+str(O):"O_"), 50, 70+20*r);
  println("  "+((T>=0)?"T"+str(T):"T_")+" "+((Q>=0)?"Q"+str(Q):"Q_")+" "+((P>=0)?"P"+str(P):"P_")+" "+((H>=0)?"H"+str(H):"H_")+" "+((O>=0)?"O"+str(O):"O_"));
}

void keyPressed() {
  if (key=='+') {
    REP=min(MAXREP, REP+1);
    create();
    loop();
  } else if (key=='-') {
    REP=max(0, REP-1);
    create();
    loop();
  }
}

void mousePressed() {
  create();
  loop();
}
