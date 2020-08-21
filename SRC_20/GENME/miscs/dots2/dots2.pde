// DOTS2 example code for http://mcreativecoding.tumblr.com project
// Tomasz Sulej, generateme.blog@gmail.com
// http://generateme.tumblr.com
// @2015


// move mouse to change visualisation
// click to change parameters
// space to save animation frames

color c1 = #2537b5;
color c2 = #ff3804;
color c3 = #000000;
color c4 = #ffffff;

// image size
final static int isize = 540;

void setup() {
  size(540, 540);
  noStroke();
  smooth(8);

  mouseClicked();
}

// how many dots per line
int dots = 45;
// distance between lines
int linestep = isize/dots;

// how many frames to save
int frames = 20;
float framestep = 1.0/frames;
float step = 0;

// folder name for animation frames
String animToken = hex((int)random(0xffffff+1), 6);
int fiter = frames + 1;

void draw() {
  background(c3);

  // each line
  for (float yy=-linestep;yy<isize+linestep;yy+=linestep) {
    // frame line position
    float y = yy+step*linestep;
    // remap y to (-3,3) boundary
    float posy = map(y, 0, isize, -3, 3);
    // weight of transformation based on y
    float weightpos = map(y, 0, isize, 0, TWO_PI);
    int i = 0;
    // each dot in line
    for (float x=-linestep;x<isize+linestep;x+=linestep) {
      // remap x to (-3,3) boundary
      float posx = map(x, 0, isize, -3, 3);
      // calculate weight
      float s = map(-cos(weightpos), -1, 1, 0, 1);
      
      // get transformation vectors
      PVector v = pdj(new PVector(posx, posy), s);
      PVector v2 = waves(new PVector(posx, posy), s);
      
      // set vector strength
      v.mult(map(mouseX, 0, isize, 0, 60));
      v2.mult(map(mouseY, 0, isize, 0, 60));
  
      // set color    
      fill( i%3==0?c1:i%3==1?c4:c2 );
      
      // draw dot moved by vectors v and v2 
      ellipse(x+v.x+v2.x, y+v.y+v2.y, 10, 10);
      i++;
    }
  }
  
  // next step
  step+=framestep;
  
  // save frames if necessary
  if (fiter<frames) {
    fiter++;
    saveFrame(animToken + "/"+ "frame######.png"); 
    println("frame " + fiter + " saved");
  }
  
  // keep step in (0,1) boundary
  step%=1.0;
}

// PDJ transformation
float pdj_a, pdj_b, pdj_c, pdj_d;
PVector pdj(PVector p, float weight) {
  return new PVector( weight * 1.5 * (sin(pdj_a * p.y) - cos(pdj_b * p.x)), 
  weight * 1.5 * (sin(pdj_c * p.x) - cos(pdj_d * p.y)));
}

// TRANSFORMATION, 2D PLANE MAPS
// write own or use Flames ones http://flam3.com/flame.pdf

// Waves transformation
float waves_b, waves_c, waves_e, waves_f;
PVector waves(PVector p, float weight) {
  float x = p.x + waves_b * sin(p.y * (1.0 / (waves_c * waves_c) ));
  float y = p.y + waves_e * sin(p.x * (1.0 / (waves_f * waves_f) ));
  return new PVector(weight * x, weight * y);
}

// change parameters
void mouseClicked() {
  pdj_a = random(-3,3);
  pdj_b = random(-3,3);
  pdj_c = random(-3,3);
  pdj_d = random(-3,3);
  waves_b = random(-1,1);
  waves_c = random(-1,1);
  waves_e = random(-1,1);
  waves_f = random(-1,1);
}

// save trigger
void keyPressed() {
  if (keyCode == 32) {
    animToken = hex((int)random(0xffffff+1), 6);
    step = 0;
    fiter = 0;
  }
}