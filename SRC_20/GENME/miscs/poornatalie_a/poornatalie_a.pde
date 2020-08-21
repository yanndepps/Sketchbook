PImage img;

void setup() {
  size(800,800);
  background(255);
  smooth(8);
  // image size 300x300
  // http://hqwallbase.com/images/big/natalie_portman_actress_faces_grayscale_monochrome_wallpaper-9529.jpg
  img = loadImage("z.jpg");
  img.loadPixels();
  noStroke();
  
  for(int y=0;y<300;y++) {
    
    // Every 5 image lines change offset
    float sep = noise(y/5,1)-0.5;
    sep *=70;
    
    for(int x=0;x<300;x++) {
      color c = img.pixels[y*300+x];
      float d = dist(x,y,150,y+20)*0.25;
      float dy = d*(noise(x/20.0,y/20,0)-0.5);
      float dy2 = d*(noise(x/20.0,y/20.0,1)-0.5);
      fill(c,100);
      
      // resize picture using two interwoven stripes with different distortion (dy or dy2)
      // stripe 1
      ellipse(sep+100+x*2,100+y*2+dy,3,3);
      ellipse(sep+100+x*2,100+y*2+1+dy,3,3);
      // stripe 2
      ellipse(sep+100+x*2+1,100+y*2+dy2,3,3);
      ellipse(sep+100+x*2+1,100+y*2+1+dy2,3,3);
    }
  }

  // canvas
  for(int x=0;x<800;x++)
    for(int y=0;y<800;y++) {
      fill((int)random(100,150),15); 
      ellipse(x,y,random(1,3),random(1,3));
    }
}


void draw() {};

void keyPressed() {
  saveFrame("f####.png");
}