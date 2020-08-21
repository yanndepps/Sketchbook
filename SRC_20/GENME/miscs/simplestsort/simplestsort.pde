void setup() {
  PImage img = loadImage("ares.jpg");
  size(img.width,img.height);
  
  image(img,0,0); // display pixels
  loadPixels(); // create pixels array
  
  int[] temp = new int[height]; // buffer for the line pixels
  for(int y=0;y<height;y++) { // for each line
    int pos = y*width; // where is my position in pixels
    arrayCopy(pixels,pos,temp,0,width); // copy line to buffer
    temp = sort(temp); // sort buffer
    arrayCopy(temp,0,pixels,pos,width); // copy back to pixels
  }
  
  updatePixels(); // update pixels to screen
}