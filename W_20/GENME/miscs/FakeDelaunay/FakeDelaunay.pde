PImage img;

final static int[][] kernel = {
//  { 6,10,0}, {10,0,-10}, {0,-10,-6}
 {2,2,0},{2,0,-2},{0,-2,-2}
}; 

int sample_size = 20; // points are chosen in grid sample_size x sample_size
int thr = 70; // edge threshold, lower - more point, higher - less

int[][] edges;
ArrayList<PVector> list;

void setup() {
  img = loadImage("mmm.jpg");
  size(600, 600);
  noFill();
  background(0);
  stroke(255,200);
  strokeWeight(0.7);
  frameRate(5);
  
  edges = new int[img.width][img.height];
  
  for(int x=0;x<width;x++) {
    for(int y=0;y<height;y++) {
      int s = 0;
      for(int xx=-1;xx<=1;xx++) {
        for(int yy=-1;yy<=1;yy++) {
          s += kernel[xx+1][yy+1] * brightness(img.get(x+xx,y+yy));
        }
      }
      edges[x][y] = abs(s);
    }
  }
 
  list = new ArrayList<PVector>();
 
  println("here");
  
// save("resanton.jpg");
}

void draw() {
  sample_size = constrain((int)map(mouseX,0,width-1,10,width/5),10,width/5);
  thr = constrain((int)map(mouseY,0,height-1,20,300),20,300);
  background(0);
  list.clear();

//sample_size = 15;
//thr = 120;

    for(int x=1;x<width-1;x+=sample_size) {
    for(int y=1;y<height-1;y+=sample_size) {
      int cx = -1;
      int cy = -1;
      int s = -1;
      for(int xx=0;xx<sample_size;xx++) {
        for(int yy=0;yy<sample_size;yy++) {
          if(x+xx<width-1 && y+yy<height-1)
          if(edges[x+xx][y+yy] > s) {
            s = edges[x+xx][y+yy];
            cx = x+xx;
            cy = y+yy;
          }
        }
      }
      if(s>thr) list.add(new PVector(cx,cy));
    }
  }
  
  for(PVector v : list) {
    for(PVector vv : list) {
      if(!v.equals(vv)) {
        float d = v.dist(vv);
        if(d<sample_size*2) {
          stroke(img.get((int)v.x,(int)v.y));
          line(v.x,v.y,vv.x,vv.y);
        }
      }
    }
  }

//if(mousePressed) saveFrame("speciman######.jpg");

}

void mouseClicked() {
  saveFrame("mmm######.jpg");
}