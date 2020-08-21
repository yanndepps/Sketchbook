// The Object 2
//
// GenerateMe submission to MCCC Sep 2016

// generateme.blog@gmail.com
// http://generateme.tumblr.com/
// http://folds2d.tumblr.com/

LowpassFilter lpf1, lpf2, lpf3;

void setup() {
  size(540,540);
  smooth(0);
  noFill();
  noStroke();
  background(20);
  noiseSeed(1000);
  
  lpf1 = new LowpassFilter(100.0, 20.0);
  lpf2 = new LowpassFilter(100.0, 10.0 );
  lpf3 = new LowpassFilter(100.0, 5.0);
}

float t = 0; // time
float stept = TWO_PI/50.0; // time step

float min_phase = -0.087;
float max_phase = 0.087;
float omega = TWO_PI * 0.0099;
int quantval = 0;

void draw() {
  fill( 100, 200, 255, 200);
  ellipse(270,270,sin(t)*400,map(cos(t),-1,1,100,400));
  fill( 255, 200, 100, 200);
  ellipse(270,270,cos(t+1)*200,tan(t-1)*200);
  
  // FM stuff
  PImage img = get();
  img.loadPixels();
  loadPixels();
  
  // separate channels
  int[][]pxls = new int[3][img.pixels.length];
  for (int i=0; i<img.pixels.length; i++) {
    int cl = img.pixels[i];
    pxls[0][i] = (cl >> 16) & 0xff;
    pxls[1][i] = (cl >> 8) & 0xff;
    pxls[2][i] = (cl) & 0xff;
  }

for (int i=0; i<3; i++) {
  float nn = 5*noise(sin(t),i/10.0);
    for (int y=0; y<height; y++) {
      int off = y * width;
      
      //reset filters each line 
      lpf1.resetFilter(map(pxls[i][off], 0, 255, min_phase, max_phase));
      lpf2.resetFilter(map(pxls[i][off], 0, 255, min_phase, max_phase));
      lpf3.resetFilter(map(pxls[i][off], 0, 255, min_phase, max_phase));

      float sig_int = 0; // integral of the signal
      float pre_m = 0; // previous value of modulated signal

      for (int x=0; x<width; x++) {
        
        /////////////////////////
        // FM part starts here
        /////////////////////////
        
        float sig = map(pxls[i][x+off], 0, 255, min_phase, max_phase); // current signal value
        sig_int += sig; // current value of signal integral

        float m = cos(omega * x + sig_int + nn); // modulate signal

        if(random(1)<0.00001) m = random(-2,2);

        if ( quantval > 0) { 
          m = map((int)map(m, -1, 1, 0, quantval), 0, quantval, -1, 1); // quantize
        }

        float dem = abs(m-pre_m); // demodulate signal, derivative
        pre_m = m; // remember current value

        // lowpass filter chain
        dem = lpf1.lowpass(dem);
        dem = lpf2.lowpass(dem);
        dem = lpf3.lowpass(dem);

        // remap signal back to channel value
        int v = constrain( (int)map(2*(dem-omega), min_phase, max_phase, 0, 255), 0, 255);
        
        //////////////////////
        // FM part ends here
        //////////////////////
        
        pxls[i][x+off] = v;
      }
    }
  }
  
  for (int i=0; i<pixels.length; i++) {
    pixels[i] = 0xff000000 | (pxls[0][i] << 16) |  (pxls[1][i] << 8) |  (pxls[2][i]);
  }

  updatePixels();

  // adjust step
  t+=stept;
  // due to blurs, save after first loop
  if (t>=TWO_PI && t<2*TWO_PI) {
    saveFrame("res/######.png");
  }
}

class LowpassFilter {
  float alpha;
  float prev;

  public LowpassFilter(float rate, float hz) {
    alpha = 0.0;
    prev = 0.0;
    setFilter(rate, hz);
  }

  void setFilter(float rate, float hz) {
    float timeInterval = 1.0/rate;
    float tau = 1.0 / (hz * TWO_PI);
    alpha = timeInterval / (tau + timeInterval);
  }

  void resetFilter(float val) { 
    prev = val;
  }

  void resetFilter() { 
    resetFilter(0);
  }

  float lowpass(float sample) {
    float stage1 = sample * alpha;
    float stage2 = prev - (prev * alpha);
    prev = (stage1 + stage2);
    return prev;
  }

  float highpass(float sample) {
    return sample - lowpass(sample);
  }
}