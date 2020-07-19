ArrayList<Segment> segments;
ArrayList<Point> intersections;
int numSegments;

void setup() {
  size(800, 800,P3D);
  smooth(16);
  numSegments=16;
  create(numSegments);
  findIntersections();
}

void create(int n) {
  segments=new ArrayList<Segment>();
  Point p1, p2;
  for (int i=0; i<n; i++) {
    p1=new Point(random(20, width-20), random(20, height-20));
    p2=new Point(random(20, width-20), random(20, height-20));
    segments.add(new Segment(p1, p2));
  }
}

void findIntersections(){
 Segment segment1, segment2; 
 Point intersection;
 intersections=new ArrayList<Point>();
 for(int i=0;i<numSegments;i++){
   segment1=segments.get(i);
   for(int j=i+1;j<numSegments;j++){
     segment2=segments.get(j);
     intersection=intersection(segment1,segment2);
     if(intersection!=null) intersections.add(intersection);
   }
 }
}

void draw() {
  background(255);
  
  for (Segment segment : segments) {
    segment.draw();
  }
  stroke(255,0,0);
  for(Point intersection : intersections){
   ellipse(intersection.x,intersection.y,10,10);   
  }
}

Point intersection(Segment segment1, Segment segment2) {
  float x1=segment1.start.x;
  float y1=segment1.start.y;
  float x2=segment1.end.x;
  float y2=segment1.end.y;
  float x3=segment2.start.x;
  float y3=segment2.start.y;
  float x4=segment2.end.x;
  float y4=segment2.end.y;
  
  float ua=(x4-x3)*(y1-y3)-(y4-y3)*(x1-x3);
  float denominator=(y4-y3)*(x2-x1)-(x4-x3)*(y2-y1);
  
  if(abs(denominator)<0.000001) return null;
  ua/=denominator;
  
  if(ua<0 || ua>1){
    return null;
  }
  
  float ub=(x2-x1)*(y1-y3)-(y2-y1)*(x1-x3);
  ub/=denominator;
  
  if(ub<0 || ub>1){
    return null;
  }
  
  float xi=x1+ua*(x2-x1);
  float yi=y1+ua*(y2-y1);
  
  return new Point(xi, yi);
}

void mousePressed(){
  create(numSegments);
  findIntersections();   
}

class Point {
  float x, y;
  Point(float x, float y) {
    this.x=x;
    this.y=y;
  }
}

class Segment {
  Point start, end;
  Segment(Point start, Point end) {
    this.start=new Point(start.x, start.y);
    this.end=new Point(end.x, end.y);
  }

  void draw() {
    fill(0);
    stroke(0);
    line(start.x, start.y, end.x, end.y);
    ellipse(start.x, start.y,3,3); 
    ellipse(end.x, end.y,3,3); 
  }
}
