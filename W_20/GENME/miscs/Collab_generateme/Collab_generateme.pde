// Code by @MetaGlitch

// Modified by Generate Me
 
float fps = 16.666;
 
int inFrames = 15;
int outFrames = 15;
int otherFrames = 90;
int numFrames = inFrames + otherFrames + outFrames;
 
float t1 = inFrames * 1.0/numFrames;
float t2 = (inFrames+otherFrames) * 1.0/numFrames;
 
float t1bis = t1*2;
float t2bis = t2-t1;
 
int samplesPerFrame = 8;
float exposure = 0.75; // exposure time in frames. >1 allowed for blending multiple frames
float subFrameAttenuation = 1; // 1 for weighting every subframe the same. <1 for attenuation effect.
boolean looping = true; // false: t=1 on the last frame; true: t=1-1/nummFrames on last frame.
 
boolean recording = false;
 
void settings() {
  size(500, 500);
}
void setup_() {
  //size(500, 500);
  smooth(8);
  noStroke();
  
  makeCircles();
}
 
float exposureCopy = exposure;
void draw_() {
  // collab settings: hit t=1 and remove motion blur on first and last frame.
  looping = false; if (frameCount==1 || frameCount==numFrames) exposure=0; else exposure=exposureCopy;
  
  background(255);
  fill(0);
 
  float x = 250;
  float y = 0;
  float size = 0; 
  
  if (t<t1) y = map(t, 0,t1, -50,50); //entry
  else if(t<t1bis) { // magnify
    float yy = map(t,t1,t1bis,0,1);
    size = map(easeElasticOut(yy),0,1,0,150); 
    y = map(easeQuarticOut(yy),0,1,50,150); 
  }
  if (t>t2) y = map(t, t2,1, 450,550); // exit
  else if(t>t2bis) { // reduce back
    float yy = map(t,t2bis,t2,0,1);
    size = map(easeElasticOut(yy),0,1,150,0);
    y = map(yy,0,1,350,450); // no easing this time, cannot match the speed
  }

  if (t>=t1bis && t<=t2bis) {
    float tt = map(t, t1bis,t2bis, 0,1);
    makeFrame_option2(tt);
  } else {  
    ellipse(x,y,100+size,100+size);
  }  
}
  
// Generate.me code
PGraphics circle[] = new PGraphics[3];
ArrayList<Integer> cutcircle[] = new ArrayList[3]; 
float droptimes[][] = new float[3][2];

int starty = 15; // 150 - 135 (half of the circle Graphics)
int stopy = 215; // 350 - 135
int diffy = stopy-starty;

void makeCircles() {
  // make colors of the circle layers, complementary then SUBTRACT of three gives black
  color rndc[] = new color[3];
  int r1 = (int)random(100,200);
  int g1 = (int)random(50);
  int b1 = (int)random(30);
  int r2 = (int)random(20);
  int g2 = (int)random(150);
  int b2 = (int)random(100,200);
  rndc[0] = color(r1,g1,b1);
  rndc[1] = color(r2,g2,b2);
  rndc[2] = color(255-r1-r2,255-g1-g2,255-b1-b2);
  
  // draw layers
  for(int i=0;i<3;i++) {
    circle[i] = createGraphics(270,270);
    circle[i].beginDraw();
    circle[i].noStroke();
    circle[i].smooth(8);
    circle[i].fill(rndc[i]);
    circle[i].ellipse(135,135,250,250);
    circle[i].endDraw();
   
    // cut layers per random stripes
    ArrayList<Integer> al = new ArrayList<Integer>();
    cutcircle[i] = al;
    for(int j=0;j<270;j+=(int)random(5,40)) al.add(new Integer(j));
    al.add(270);
    
    // when start drop
    droptimes[i][0] = random(i*0.1,(i+1)*0.1); // 0.0 - 0.3
    // when stop drop
    droptimes[i][1] = random(0.5+i*0.1,0.5+(i+1)*0.1); // 0.5 - 0.8
  }
}

float easeSelect(int num, float time) {
  switch (num) {
    case 0: return easeQuadraticIn(time);
    case 1: return easeQuadraticIn(time)*time;
    case 2: return easeQuarticIn(time);
    default: return time;
  }
}

void makeFrame_option2(float time) {
  for(int c=0; c<3; c++) {
    ArrayList<Integer> al = cutcircle[c];
    for(int i=0;i<al.size()-1;i++) {
      int y1 = al.get(i).intValue();
      int y2 = al.get(i+1).intValue();
      
      float diff = (270-y1)/1500.0; // every part starts a little bit later
      float starttime = droptimes[c][0] + diff;
      float stoptime = droptimes[c][1] + diff;
      int off = (int)map(easeSelect(c,constrain(map(time,starttime,stoptime,0,1),0,1)),0,1,0,diffy);
        
      blend(circle[c],0,y1,270,y2-y1,115,starty+off+y1,270,(y2-y1),SUBTRACT);
    }
  }
}

float cosmap(float time) { // 0 - 100
  return 50 * (1 - cos(map(time,0,1,0,TWO_PI)));
}

void makeFrame_option1(float time) {
  blend(circle[0],0,0,270,270,(int)(115+cosmap(time)),(int)map(time,0,1,starty,stopy),270,270,SUBTRACT);
  blend(circle[1],0,0,270,270,115,(int)map(easeQuarticIn(sqrt(time)),0,1,starty,stopy),270,270,SUBTRACT);
  blend(circle[2],0,0,270,270,(int)(115-cosmap(time)),(int)map(easeQuarticIn(time),0,1,starty,stopy),270,270,SUBTRACT);
}

 
float easeElasticOut(float t) {
  float ts = t*t;
  float tc = t*ts;
  return 33.0*tc*ts -106.0*ts*ts + 126.0 * tc - 67.0 *ts + 15.0*t; 
} 

float easeQuadraticIn(float t) {
  return t*t;
} 
 
float easeQuarticIn(float t) {
  float ts = t*t;
  return ts*ts;
} 
 
float easeQuarticOut(float t) {
  float ts = t*t;
  float tc = t*ts;
  return -ts * ts + 4.0 * tc - 6.0 * ts + 4.0 * t;
} 
 
//////////////////
 
float pingpong(float t) { //  / => /\
  return 1-2*abs(t-0.5);
}
  
float ease(float t, float e) {
  return t < 0.5 ? 0.5 * pow(2*t, e) : 1 - 0.5 * pow(2*(1 - t), e);  
}
 
float ease(float t, float in, float out) {
  return (1-t)*ease(t, in) + t*ease(t, out);  
}

// Code by @MetaGlitch
 
float t;
float[][] result;
 
void setup() {
  setup_();
  result = new float[width*height][3];
}
 
void draw() {
  if (!recording) {
    if (mousePressed) {
      frameRate(60);
      t = mouseX*1.0/width;
      if (mouseButton == LEFT) t = constrain(t, 0, 1);
      while(t<0) t+=1.0;
      while(t>1) t-=1.0;
    } else {
      frameRate(fps);
      t = float((frameCount-1)%numFrames) / numFrames;
    }
    draw_();  
  } else { // sub frame rendering inspired by @beesandbombs
    for (int i=0; i<width*height; i++) for (int a=0; a<3; a++) result[i][a] = 0;
 
    float divider = 0; 
    for (int sa=0; sa<samplesPerFrame; sa++) {
      noLights(); lights(); // reset lights
      t = map(frameCount-1 + exposure*sa/samplesPerFrame, 0, numFrames - (looping?0:1) , 0, 1) % 1;
      pushMatrix();
      draw_();
      popMatrix();
      loadPixels();
      float weight = pow(subFrameAttenuation, samplesPerFrame-sa-1);
      divider += weight;
      for (int i=0; i<pixels.length; i++) {
        result[i][0] += weight * (pixels[i] >> 16 & 0xff);
        result[i][1] += weight * (pixels[i] >> 8 & 0xff);
        result[i][2] += weight * (pixels[i] & 0xff);
      }
    }
 
    loadPixels();
    for (int i=0; i<pixels.length; i++)
      pixels[i] = 0xff << 24 | 
        int(result[i][0]*1.0/divider) << 16 | 
        int(result[i][1]*1.0/divider) << 8 | 
        int(result[i][2]*1.0/divider);
    updatePixels();
 
    saveFrame("frames/f###.png");
    if (frameCount==numFrames)
      exit();
  }
  
}