// 60602474121
void setup() {
  size(600, 700);
  surface.setResizable(true);
  noStroke();
  fill(0);
}

void draw() {
  background(255);

  float sec = second();
  float min = minute();
  float h = hour();
  float d = day();
  float w = day()/4;
  float m = month();
  float y = year();

  sec = map(sec, 0, 59, 0, width/15);
  min = map(min, 0, 59, 0, width/15);
  h = map(h, 0, 23, 0, width/6);
  d = map(d, 1, 31, 0, width/1.75);
  w = map(w, 0.25, 7.75, 0, width);
  m = map(m, 1, 12, 0, width/3);
  //--- 
  for (float i = -width/15; i < width; i += width/30) {
    rect(i+sec, 0, width/60, height/7);
  }
  //---
  for (float i = -width/15; i < width; i += width/30) {
    rect(i+min, height/7, width/60, height/7);
  }
  //--- 
  for (float i = -width/6; i < width; i += width/12) {
    rect(i+h-2, height*2/7, width/24, height/7);
  }
  //--- 
  for (float i = -width/1.75; i < width; i += width/3.5) {
    rect(i+d, height*3/7, width/7, height/7); 
  }
  //--- 
  for (float i = -width/1; i < width; i += width/2) {
    rect(i+w, height*4/7, width/4, height/7);
  }
  //---  
  for (float i = -width/3; i < width; i += width/6) {
    rect(i+m, height*5/7, width/12, height/7);
  }
  //---
  rect(0, height*6/7, width, height/7);
}
