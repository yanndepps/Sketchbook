PImage img;

void setup() {
  size(800,800);
  background(255);
  smooth(8);
  // image size 300x300
  // http://hqwallbase.com/images/big/natalie_portman_actress_faces_grayscale_monochrome_wallpaper-9529.jpg
  img = loadImage("w.jpg");
  img.loadPixels();
  noStroke();
  
  for(int y=0;y<300;y++) {

    // rips separation
    int sep = (int)(100+20*noise(y/20.0,1));
    int sep2 = (int)(150+20*noise(y/20.0,2));
    int sep3 = (int)(180+20*noise(y/20.0,3));
    
    for(int x=0;x<300;x++) {
      color c = img.pixels[y*300+x];
      fill(c,80);
      int sepx = 0;
      if(x>sep) sepx = 40;
      if(x>sep2) sepx = 70;
      if(x>sep3) sepx = 120;
      
      pushMatrix();
      
      if(x>sep3 || x<sep) {
        translate(400,400);
        rotate(0.1);
        translate(-400,-400);
      }
      
      ellipse(sepx+50+x*2,100+y*2,random(1,5),random(1,5));
      ellipse(sepx+55+x*2,100+y*2+1,random(1,5),random(1,5));
      ellipse(sepx+50+x*2+1,100+y*2,random(1,5),random(1,5));
      ellipse(sepx+45+x*2+1,100+y*2+1,random(1,5),random(1,5));
      
      popMatrix();
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