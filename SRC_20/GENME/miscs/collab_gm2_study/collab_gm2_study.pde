PGraphics g ;

void setup() {
  size(500,500);
  smooth(8);
  noStroke();
  fill(0);
    g = createGraphics(270,270);
    g.beginDraw();
    g.background(255);
    g.noStroke();
    g.smooth(8);
    g.fill(0);
    g.ellipse(135,135,250,250);
    g.endDraw();
    g.loadPixels();
}

final color bl = color(255);
float posx; 
float rot;

void draw() {
  background(255);
  posx = constrain(map(mouseX,50,450,0,1),0,1);
  rot = map(posx,0,1,0,TWO_PI);
  posx = cosmap(posx);
  
  for(int x=0;x<270;x++) {
    for(int y=0;y<270;y++) {
      color c = g.pixels[x+y*270];
      if(c != bl) {
        drawme(x+0.33,y,50,150);
        drawme(x-0.33,y,c,150);
        drawme(x,y+0.33,50,150);
        drawme(x,y-0.33,c,150);
        drawme(x,y,c,0);
      }
    }
  }  
  
}

void drawme(float x,float y,color c, int alpha) {
   float xx = map(x,0,270,-3,3);
   float yy = map(y,0,270,-3,3);
   PVector res = transform(new PVector(xx,yy),posx);
   xx = map(res.x,-3,3,115,385);
   yy = map(res.y,-3,3,115,385);
   if(alpha >0) fill(c,alpha); else fill(c);
   rect(xx,yy,1,1);
}

final float sgn(float a) {
  if(a == 0.0) return 0.0;
  return a > 0.0 ? 1.0 : -1.0;
}

PVector map1(PVector p) {
  float newx = 3*sgn(p.x) * pow(abs(p.x),0.2513);
  float newy = 3*sgn(p.y) * pow(abs(p.y),0.2513);
  return new PVector(newx,newy);
}

PVector sinusoidal(PVector p) {
  return new PVector(3.0*sin(p.x),3.0*sin(p.y));
}

PVector julia(PVector p) {
    float r = 1.75 * sqrt(p.mag());
    float theta = 0.5 * atan2(p.x,p.y) + (int)(2.0 * random(0,1)) * PI;
    float x = r * cos(theta);
    float y = r * sin(theta);
    return new PVector(x,y);
  }

PVector spherical(PVector p) {
    float r =2.0 / (sq(p.x)+sq(p.y) + 1.0e-10);
    return new PVector(r * p.x, r * p.y);      
  }

PVector transform(PVector p, float weight) {
   PVector res =  
   julia(spherical(sinusoidal(map1(p))));
  
   return rotate(new PVector( map(weight,0,1,p.x,res.x),
                       map(weight,0,1,p.y,res.y)),rot); 
}

PVector rotate(PVector p, float angle) {
    float ca = cos(angle);
    float sa = sin(angle);
    return new PVector(ca * p.x - sa * p.y, sa * p.x + ca * p.y);
  }
  
float cosmap(float time) {
  return 0.5*(1 - cos(map(time,0,1,0,TWO_PI)));
}  