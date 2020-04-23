
//DOF: Buffers for the frame averaging
float[] r;
float[] g;
float[] b;
//DOF: Camera settings
float fov;
float camz;
//DOF: Number of samples to average
int samples;

//Bright sprite
PImage sprite;
float ax,ay;

//Tree
boolean grow;
Tree tree;
float min_dist = 20;
float max_dist = 400;
PVector[] directions;

void setup() {
  fullScreen(P3D);
  smooth(16);
  noCursor();
  imageMode(CENTER);
  r=new float[width*height];
  g=new float[width*height];
  b=new float[width*height];

  //default camera settings
  fov=radians(60);
  camz=height/2/tan(0.5*fov);

  directions=new PVector[]{
    new PVector(-0.26286500f, 0.0000000f, 0.42532500f), 
    new PVector(0.26286500f, 0.0000000f, 0.42532500f), 
    new PVector(-0.26286500f, 0.0000000f, -0.42532500f), 
    new PVector(0.26286500f, 0.0000000f, -0.42532500f), 
    new PVector(0.0000000f, 0.42532500f, 0.26286500f), 
    new PVector(0.0000000f, -0.42532500f, 0.26286500f), 
    new PVector(0.0000000f, 0.42532500f, -0.26286500f), 
    new PVector(0.0000000f, -0.42532500f, -0.26286500f), 
    new PVector(0.42532500f, 0.26286500f, 0.0000000f), 
    new PVector(-0.42532500f, 0.26286500f, 0.0000000f), 
    new PVector(0.42532500f, -0.26286500f, 0.0000000f), 
    new PVector(-0.42532500f, -0.26286500f, 0.0000000f)

  };
  createSprite();
  tree = new Tree();
  for (int r=0; r<256; r++) {
   tree.grow();
  }
  samples=256;
}

void createSprite() {
  int maxSpriteSize=256;
  int minSpriteSize=8;
  float glowKernelWidth=1.8f;// glow core size parameter
  float glowKernelDecayPower=2.0f;// glow core decay power (~1.4-3.6)
  int reqGlowKernelSize =constrain(5*(int)pow(100f*glowKernelWidth, 1f/glowKernelDecayPower), minSpriteSize, maxSpriteSize);// required image size to accomodate the glow kernel
  int half=reqGlowKernelSize/2;
  reqGlowKernelSize=2*half;
  sprite=createImage(reqGlowKernelSize, reqGlowKernelSize, RGB);
  float r2, brightness;
  for (int i=0; i <  reqGlowKernelSize; i++) {
    for (int j=0; j <  reqGlowKernelSize; j++) {
      r2=(i-half)*(i-half)+(j-half)*(j-half);
      brightness=255.999999f*glowKernelWidth/(glowKernelWidth+pow(r2, 0.5*glowKernelDecayPower));// radial symmetric decreasing function
      sprite.pixels[i+reqGlowKernelSize*j] = color(brightness, brightness);
    }
  }
}

//Initialize the buffers
void initRGB() {
  for (int i=0; i<width*height; i++) {
    r[i]=0;
    g[i]=0;
    b[i]=0;
  }
}

//First draw the samples, when complete draw the average
void draw() {
  if (frameCount<=samples) {
    pushMatrix();
    drawSample();
    popMatrix();
    loadPixels();
    for (int i=0; i<pixels.length; i++) {
      r[i] += (pixels[i] >> 16 & 0xff);
      g[i] += (pixels[i] >> 8 & 0xff);
      b[i] += (pixels[i] & 0xff);
    }
  } else {
    loadPixels();
    for (int i=0; i<pixels.length; i++) {
      pixels[i] = 0xff << 24 | 
        int(r[i]/samples) << 16 | 
        int(g[i]/samples) << 8 | 
        int(b[i]/samples);
    }
    updatePixels();
    noLoop();
  }
}

//Draw a single sample
void drawSample() {
  background(0);
  sampleCameraInDisk(1.7, 20.0);//first parameter tunes depth of focus (trial and error, 1.0-2.4 seems to work for this image), second parameter is radius of disk
 
  rotateY(ay=radians(30));
  rotateX(ax=radians(90));
  drawThing();
}

//Pick a random camera position in a disk with radius rcentered on the Z-axis,aimed at (0,0,0)
void sampleCameraInDisk(float focus, float radius) {
  float r = radius*sqrt(random(1.0));
  float t = random(TWO_PI);
  camera(r * cos(t), r * sin(t), camz, r * cos(t), r * sin(t), 0, 0, 1, 0);
  float f=camz/10.0 * (float) Math.tan(fov / 2);
  float ymax = f;
  float ymin = -f;
  float xmin = -f * width/float(height);
  float xmax = f * width/float(height);
  float offsetx=focus*r * cos(t)*f/camz;
  float offsety=focus*r * sin(t)*f/camz;
  frustum(xmin-offsetx, xmax-offsetx, ymin+offsety, ymax+offsety, camz/10.0, camz*10.0);
}

void drawThing() {
  pushMatrix();
  tree.show();
  popMatrix();
}

void mousePressed() {
  frameCount=0;
  initRGB();
  tree = new Tree();
  for (int r=0; r<256; r++) {
   tree.grow();
  }
  loop();
}
