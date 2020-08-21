// The Object
//
// GenerateMe submission to MCCC Sep 2016

// generateme.blog@gmail.com
// http://generateme.tumblr.com/
// http://folds2d.tumblr.com/

void setup() {
  size(540, 540);
  smooth(4);
  noStroke();
  background(20);
  noiseSeed(1000);
}

float t = 0; // time
float stept = TWO_PI/100.0; // time step

void draw() {
  // simulate motion blur
  fill(20, 100);
  rect(0, 0, width, height);
  filter(BLUR, 1);

  // some random color, doesn't match resulting color
  fill( 100, 200, 255, 200);
  
  float tant = tan(t);

  for (float y=-2; y<2; y+=0.002) {
    for (float x=-2; x<2; x+=noise (x-tant, y+tant)/5.0  ) { // stripes

      float thr = getThr( sqrt(x*x+y*y) ); // threshold value for noise 

      if (thr > noise(3*x, 1+3*y, 1+tant)) { // x symmetry noise, draw only if noise is less than threshold
        // map to screen
        float xx = map(x, -2, 2, 0, width);
        float yy = map(y, -2, 2, 0, height);

        ellipse(xx, yy, 1.6, 1.6);
      }
    }
  }

  // postprocessing
  loadPixels();

  // YPbPr colorspace lowpass filters, filter chroma more than luma
  // use time to adjust cutoff
  Filter fY = new Filter(100000, map(sq(sq(cos(t/2))), 1, 0, 5000, 20000));
  Filter fPb = new Filter(10000, map(-cos(t), -1, 1, 1000, 10));
  Filter fPr = new Filter(10000, 200*noise(sin(t)));

  for (int y=0; y<height; y++) {
    int off = y * width;

    // reset filters each line
    fY.reset();
    fPb.reset();
    fPr.reset();

    // RGB -> YPbPr -> filter each channel -> RGB
    for (int x=0; x<width; x++) {
      PVector c = toYPbPr(pixels[x+off]);
      c.x = fY.lowpass(c.x);
      c.y = fPb.lowpass(c.y);
      c.z = fPr.lowpass(c.z);
      pixels[x+off] = fromYPbPr(c);
    }
  }
  updatePixels();

  // adjust step
  t+=stept;
  // due to blurs, save only after first circle
  if (t>=TWO_PI && t<2*TWO_PI) {
    //saveFrame("res/######.png");
  }
}

// threshold mask function
final static float minthr = 0.2;
float getThr(float r) {
  if (r<1.0) return 0.7;
  if (r>1.6) return minthr;

  float m = cos(map(r, 1.0, 1.6, 0, TWO_PI));
  return map(m, 1, -1, 0.7, minthr);
}

// visualize threshold mask, call it in setup (comment draw()) 
void drawThr() {
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      float xx = map(x,0,width,-2,2);
      float yy = map(y,0,height,-2,2);
      float thr = getThr( sqrt(xx*xx+yy*yy) );
      fill(thr*255);
      rect(x,y,1,1);
    }
  }
}

// lowpass filter
class Filter {
  float alpha = 0;
  float prev = 0;

  public Filter(float rate, float hz) {
    float timeInterval = 1.0/rate;
    float tau = 1.0 / (hz * TWO_PI);
    alpha = timeInterval / (tau + timeInterval);
    prev = 0.0;
  }

  void reset() { 
    prev = 20.0;
  }

  float lowpass(float sample) {
    float stage1 = sample * alpha;
    float stage2 = prev - (prev * alpha);
    prev = (stage1 + stage2);
    return prev;
  }
}

// convert RGB -> YPbPr
PVector toYPbPr(color c) {
  int R = getR(c);  
  int B = getB(c);

  int Y = getLuma(c);
  int Pb = B - Y;
  int Pr = R - Y;
  if (Pb<0) Pb+=256;
  if (Pr<0) Pr+=256;
  return new PVector(Y, Pb, Pr);
}

// YPbPr -> RGB
color fromYPbPr(PVector c) {
  int Y = (int)c.x;
  int B = (int)c.y + Y;
  int R = (int)c.z + Y;
  if (R>255) R-=256;
  if (B>255) B-=256;

  int G = (int)((Y-0.2126*R-0.0722*B)/0.7152);

  return blendRGB(R, G, B);
}

color blendRGB(int r, int g, int b) {
  return 0xff000000 | (constrain(r, 0, 255) << 16) |  (constrain(g, 0, 255) << 8 ) | constrain(b, 0, 255);
}

final int getR(color c) { 
  return (c & 0xff0000) >> 16;
}
final int getG(color c) { 
  return (c & 0xff00) >> 8;
}
final int getB(color c) { 
  return c & 0xff;
}
final int getLuma(color c) { 
  return constrain((int)(0.2126*getR(c)+0.7152*getG(c)+0.0722*getB(c)), 0, 255);
}
