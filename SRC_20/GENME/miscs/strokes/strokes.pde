// Original: http://www.openprocessing.org/sketch/145401
// adaptation to images, Tomasz Sulej, generateme.blog@gmail.com

// put image filename here:
String imagefilename = "w.jpg";

// run, after 30 iterations result will be saved automatically
// or click mouse when ready

/////////////////////////////////////
int n=2000;
float [] cx=new float[n];
float [] cy=new float[n];

PImage img;
int len;

void setup() {
  img = loadImage(imagefilename);
  
  size(600, 600);
  len = (width<height?width:height)/6;
  
  background(0);
  for (int i=0;i<n;i++) {
    cx[i]=random(width);
    cy[i]=random(height);
  }
  
  smooth(8);
  strokeWeight(0.3);
}
 
int tick = 0;
 
void draw() {  
  for (int i=1;i<n;i++) {
    color c = img.get((int)cx[i], (int)cy[i]);
    stroke(c);
    point(cx[i], cy[i]);
    // you can choose channels: red(c), blue(c), green(c), hue(c), saturation(c) or brightness(c)
    cy[i]+=sin(map(brightness(c),0,255,0,TWO_PI));
    cx[i]+=cos(map(brightness(c),0,255,0,TWO_PI));
  }
 
  if (frameCount>len) {
    frameCount=0;
    println("iteration: " + tick++);
    for (int i=0;i<n;i++) {
      cx[i]=random(width);
      cy[i]=random(height);
    }
    
    if(tick == 30) saveFrame("res_"+(int)random(10000,99999)+"_"+imagefilename);
  }
}

void mouseClicked() {
  saveFrame("res_"+(int)random(10000,99999)+"_"+imagefilename);
}