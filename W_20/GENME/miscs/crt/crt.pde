// based on http://www.magneticrealms.com/posts/2014/02/03/a-crt-filter-without-shaders/
// generateme.tumblr.com
// generateme.blog@gmail.com

void setup() {
  PImage img = loadImage("w.jpg");
  size(600, 600);
  noFill();
  smooth(8);
  
  img.resize(width/2,height/2);
  PImage l1 = img;
  l1.resize(width,height);
  PImage l2 = l1.get();
  
  // layer one
  l1.loadPixels();
  for(int i=0;i<l1.pixels.length;i++) {
    color c = l1.pixels[i];
    l1.pixels[i] = color(red(c),green(c)/1.6,blue(c)/5.2);
  }
  l1.updatePixels();
  image(l1,0,0);
  
  // RGB scan lines 
  for(int y=0;y<height;y+=3) {
    stroke( color(random(200,220),0,0), 42);
    line(0,y,width,y);
    stroke( color(0,random(200,220),0), 42);
    line(0,y+1,width,y+1);
    stroke( color(0,0,random(200,220)), 42);
    line(0,y+2,width,y+2);
  }
  
  // layer 2, moved one pixel
  l2.loadPixels();
  for(int i=0;i<l2.pixels.length;i++) {
    color c = l2.pixels[i];
    l2.pixels[i] = color(red(c)/5.2,green(c)/1.6,blue(c));
  }
  l2.updatePixels();
  
  // blend layers
  blend(l2,0,0,width,height,1,0,width-1,height,ADD);
  
  save("res.jpg");
}