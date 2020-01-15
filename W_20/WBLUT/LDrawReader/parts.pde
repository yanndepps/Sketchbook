//ldraw models have conditional lines: lines that are only visible when they're part of the outline, which is view-dependent.
class ConditionalLine {
  float x1, y1, z1;
  float x2, y2, z2;
  float tx1, ty1, tz1;
  float tx2, ty2, tz2;
  color col;

  ConditionalLine(float x1, float y1, float z1, float x2, float y2, float z2, float tx1, float ty1, float tz1, float tx2, float ty2, float tz2, color col) {
    this.x1=x1;
    this.y1=y1;
    this.z1=z1; 
    this.x2=x2;
    this.y2=y2;
    this.z2=z2;
    this.tx1=tx1;
    this.ty1=ty1;
    this.tz1=tz1; 
    this.tx2=tx2;
    this.ty2=ty2;
    this.tz2=tz2;
    this.col=col;
  }

  void draw() {
    float sx1, sy1, sx2, sy2, tsx1, tsy1, tsx2, tsy2;
    sx1=screenX(x1, y1, z1);
    sy1=screenY(x1, y1, z1);
    sx2=screenX(x2, y2, z2);
    sy2=screenY(x2, y2, z2);
    tsx1=screenX(tx1, ty1, tz1);
    tsy1=screenY(tx1, ty1, tz1);
    tsx2=screenX(tx2, ty2, tz2);
    tsy2=screenY(tx2, ty2, tz2);  
    
    float s1=(sx2 - sx1)*(tsy1 - sy1) - (sy2 - sy1)*(tsx1 - sx1);
    float s2=(sx2 - sx1)*(tsy2 - sy1) - (sy2 - sy1)*(tsx2 - sx1);
    //Only draw a conditional line if the two faces sharing it would be drawn on the same side of the edge
    if (s1*s2>=0) {
      stroke(col);
      line(x1, y1, z1, x2, y2, z2);
    }
  }
}

//class to hold te transformation information in each part
class M44{
 float x,y,z;
 float a,b,c,d,e,f,g,h,i;
 
 M44(){
  this.x=0;
  this.y=0;
  this.z=0;
  this.a=1;
  this.b=0;
  this.c=0;
  this.d=0;
  this.e=-1;//-y is up in LDraw convention
  this.f=0;
  this.g=0;
  this.h=0;
  this.i=1; 
 }
 
 M44(float x, float y, float z, float a, float b, float c, float d, float e, float f, float g, float h, float i){
  this.x=x;
  this.y=y;
  this.z=z;
  this.a=a;
  this.b=b;
  this.c=c;
  this.d=d;
  this.e=e;
  this.f=f;
  this.g=g;
  this.h=h;
  this.i=i; 
 }
 
 M44 mul(M44 M){
   return new M44(
   x*M.a+y*M.b+z*M.c+M.x,
   x*M.d+y*M.e+z*M.f+M.y,
   x*M.g+y*M.h+z*M.i+M.z,
   
   a*M.a+d*M.b+g*M.c,
   b*M.a+e*M.b+h*M.c,
   c*M.a+f*M.b+i*M.c,
   a*M.d+d*M.e+g*M.f,
   b*M.d+e*M.e+h*M.f,
   c*M.d+f*M.e+i*M.f,
   a*M.g+d*M.h+g*M.i,
   b*M.g+e*M.h+h*M.i,
   c*M.g+f*M.h+i*M.i);
 }
  
}
