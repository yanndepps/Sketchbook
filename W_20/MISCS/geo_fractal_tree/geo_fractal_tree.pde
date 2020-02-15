PVector pos;
PVector vel;
float turnAngle;
int pathIndex;
int stepCount;
float branchLength = 40; // length of each branch segment
float polySides = 5; // angle of each branch
int bitLength = 12; // number of left/right branches up each branch

void setup() {
  size(800, 800);
  background(0);
  pos = new PVector(0, 0);
  turnAngle = (TWO_PI / polySides);
  vel = PVector.fromAngle(0 * turnAngle);
  vel.mult(branchLength);
}

void draw() {
  translate(width/2,height/2);
  rotate(-HALF_PI);

  stroke(255,8);
  pos.add(vel);
  line(pos.x, pos.y, pos.x - vel.x, pos.y - vel.y);

  float angle = vel.heading();
  if (getBit(pathIndex, bitLength - stepCount)) {
    angle -= turnAngle;
  } else {
    angle += turnAngle;
  }
  
  vel = PVector.fromAngle(angle);     
  vel.mult(branchLength);

  stepCount++;
  if (stepCount > bitLength) {
    fill(255,8);
    ellipse(pos.x, pos.y, 5,5);
    pos = new PVector(0, 0);
    vel = PVector.fromAngle(0 * turnAngle);
    vel.mult(branchLength);
   //}
   stepCount = 0;
    pathIndex++;
    if(pathIndex == pow(2,bitLength)) { noLoop(); save("./data/pattern.jpg");}
    //background(255);
    println(pathIndex);
  }
}

boolean getBit(int dec, int n) {
  return ((dec >> (n - 1)) & 1) == 1;  
}
