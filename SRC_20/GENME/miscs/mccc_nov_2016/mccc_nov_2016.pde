// generateme.tumblr.com
// mccc Nov 2016

// the main idea:
// SOUND
// - generate sound with 8bit audio formula (concept: http://countercomplex.blogspot.com/2011/10/algorithmic-symphonies-from-one-line-of.html)
// - left channel, values from formula, right channel reversed ulaw
// - equalize (more bass, less treble)
// - add delay
// - save as RAW 8bit signed, stereo, 24576 samples per second
// VIDEO
// - take sound data
// - draw 4 rings, based on noise based on amplitude, time, tan of time 
// - every 1/4 of second, rotate canvas
// - background: draw squares based on bits from samples
// - postprocessing, bass/treble filter + rgb channels shift
//
// import to audacity as RAW 8-bit unsigned, little endian, 2 channels, Sample rate: 24576
// export as WAV (aiff)
//
// convert frames and audio to video: 
// ffmpeg.exe -f image2 -i res/%06d.jpg -i test.aiff -preset slow -tune animation -profile:v high -level 5.2 -g 12 -qp 14 -movflags +faststart res.mp4 -y

final static float SAMPLE_RATE = 24576;
final static float SAMPLE_FACTOR = 8192 / SAMPLE_RATE;
final static float SAMPLE_SEC = SAMPLE_RATE / 4;

byte[] buff;

void setup() {
  size(600, 600);
  background(30);
  noStroke();
  fill(30, 50);
  frameRate(25);
  smooth(8);

  noiseSeed(1001);

  buff = new byte[(int)SAMPLE_RATE*260*2];

  float[] bufff = new float[buff.length];

  AuBassTreble abt_l = new AuBassTreble(12, -3);
  AuBassTreble abt_r = new AuBassTreble(12, -3);

  TReverb tr_l = new TReverb();
  TReverb tr_r = new TReverb();

  long time = 0;
  float lMin=0, lMax=0, rMin=0, rMax=0;
  for (int i=0; i<buff.length/2; i++) {
    int l = i*2;
    int r = i*2+1;

    long t = (int)(time * SAMPLE_FACTOR);

    long expr =  i<(buff.length/2-SAMPLE_RATE*4) ? t*(54321>>(t>>9&(t>>14))&(12+t>>14))&osin(((t<<2)+osin(t>>2))>>4)|(t>>3) : 0L;

    float sample = map(expr&0xff, 0, 255, -1, 1);

    bufff[l] = abt_l.doFilter(tr_l.doFilter(sample));
    bufff[r] = abt_r.doFilter(tr_r.doFilter(revulaw(sample)));

    if (lMin > bufff[l]) lMin = bufff[l];
    if (lMax < bufff[l]) lMax = bufff[l];
    if (rMin > bufff[r]) rMin = bufff[r];
    if (rMax < bufff[r]) rMax = bufff[r];

    time++;
  }

  // normalize
  for (int i=0; i<buff.length/2; i++) {
    buff[i*2] = (byte)map(bufff[i*2], lMin, lMax, -128, 127);
    buff[i*2+1] = (byte)map(bufff[i*2+1], rMin, rMax, -128, 127);
  }

  // import to audacity as RAW 8-bit unsigned, little endian, 2 channels, Sample rate: 24576
  // export as WAV
  saveBytes("test.raw", buff);

  b = createGraphics(width, height);
  b.noStroke();
  b.smooth(8);
  b.beginDraw();
  b.background(30);
  b.endDraw();
}

PGraphics b;

void draw() {
  b.beginDraw();
  b.noStroke();
  b.smooth(8);
  b.fill(30, 30);
  b.rect(0, 0, width, height);
  b.filter(BLUR, 2);

  int fc = (int)floor((frameCount-1)/6.25);
  int idx = (int)(fc*SAMPLE_SEC*2);

  b.translate(width/2, height/2);

  if (idx>=buff.length) {
    noLoop();
    println("finished");
  } else {
    b.rotate(fc/7.0);
    boolean cb = random(1)<0.02;
    for (int i=0; i<SAMPLE_SEC; i+=4) {
      if (cb) b.fill(100, 59, 59, 200); 
      else
        b.fill( map(buff[idx+i*2]&0xff, 0, 255, 50, 255), 170);

      float n = map( noise( buff[idx+i*2]/200.0, (frameCount/400.0)+tan(TWO_PI*((frameCount/6.25)/200.0))), 0, 1, 0, 500);
      float ang = map(i, 0, SAMPLE_SEC, 0, TWO_PI);

      b.rect(n*cos(ang), n*sin(ang), 3, 3);
      b.rect(0.5*n*cos(ang+PI), 0.5*n*sin(ang+PI), 1, 1);
      b.rect(1.5*n*cos(ang+HALF_PI), 1.5*n*sin(ang+HALF_PI), 2, 2);
      b.rect(2*n*cos(ang-HALF_PI), 2*n*sin(ang-HALF_PI), 1, 1);
    }
    //

    b.endDraw();

    image(b, 0, 0);

    for (int x=0; x<120; x++) {
      for (int y=0; y<120; y++) {
        int xyidx = y+x*120;
        int i = 1+2*(int)map(xyidx, 0, 14400, 0, SAMPLE_SEC);
        int val = buff[i+idx];

        fill(map(val, -128, 127, 0, 255), 20);

        int bidx = (int)round(map(xyidx, 0, 14400, 0, 6));
        if ( ( val&(1<<bidx)) > 0) rect(x*10, y*10, 10, 10);
      }
    }

    AuBassTreble tr = new AuBassTreble(2, -5);
    AuBassTreble tg = new AuBassTreble(3, -5);
    AuBassTreble tb = new AuBassTreble(-1, 5);
    loadPixels();

    for (int i=0; i<pixels.length; i++) {
      int r = (int)constrain( tr.doFilter(red(pixels[(i+1) % pixels.length])), 0, 255);
      int g = (int)constrain( tg.doFilter(green(pixels[i])), 0, 255);
      int b = (int)constrain( tb.doFilter(blue(pixels[(i+2) % pixels.length])), 0, 255);
      pixels[i] = color(r, g, b);
    }

    updatePixels();

    saveFrame("res/######.jpg");
  }
}

static final float U = 255.0;
static final float U1 = 1.0 + U;
static final float rU = 1.0/255.0;

float revulaw(float x) {
  float sgnx = x < 0 ? -1.0 : 1.0;
  return sgnx * rU * (pow(U1, abs(x))-1.0);
}

long n(float v) {
  return (long)map(v, -1, 1, 0, 255);
}

long osin(long v) {
  return n( sin( (v&0xff) * PI/128.0) );
}

// https://github.com/audacity/audacity/blob/master/src/effects/BassTreble.cpp
public class AuBassTreble { 
  float dB_bass = 12;
  float dB_treble = -3;
  float slope_b = 0.8; 
  float slope_t = 0.8;
  float hzBass = 150.0;
  float hzTreble = 5000.0; 
  float b0, b1, b2, a0, a1, a2, xn2Bass, xn1Bass, yn2Bass, yn1Bass, b0Bass, b1Bass, b2Bass, xn1Treble, xn2Treble, yn1Treble, yn2Treble, a0Bass, a1Bass, a2Bass, a0Treble, a1Treble, a2Treble, b0Treble, b1Treble, b2Treble;
  float mSampleRate = SAMPLE_RATE;

  public AuBassTreble(float b, float t) {
    dB_bass = b;
    dB_treble = t;
    initialize();
  }

  public void initialize() { 
    xn1Bass = xn2Bass = yn1Bass = yn2Bass = 0.0;
    xn1Treble = xn2Treble = yn1Treble = yn2Treble = 0.0;

    float w = (2 * PI * hzBass / mSampleRate);
    float a = exp((log(10.0) *  dB_bass / 40));
    float b = sqrt(((a * a + 1) / slope_b - (pow((a - 1), 2))));

    b0Bass = a * ((a + 1) - (a - 1) * cos(w) + b * sin(w));
    b1Bass = 2 * a * ((a - 1) - (a + 1) * cos(w));
    b2Bass = a * ((a + 1) - (a - 1) * cos(w) - b * sin(w));
    a0Bass = ((a + 1) + (a - 1) * cos(w) + b * sin(w));
    a1Bass = -2 * ((a - 1) + (a + 1) * cos(w));
    a2Bass = (a + 1) + (a - 1) * cos(w) - b * sin(w);

    w = (2 * PI * hzTreble / mSampleRate);
    a = exp((log(10.0) * dB_treble / 40));
    b = sqrt(((a * a + 1) / slope_t - (pow((a - 1), 2))));

    b0Treble = a * ((a + 1) + (a - 1) * cos(w) + b * sin(w));
    b1Treble = -2 * a * ((a - 1) + (a + 1) * cos(w));
    b2Treble = a * ((a + 1) + (a - 1) * cos(w) - b * sin(w));
    a0Treble = ((a + 1) - (a - 1) * cos(w) + b * sin(w));
    a1Treble = 2 * ((a - 1) - (a + 1) * cos(w));
    a2Treble = (a + 1) - (a - 1) * cos(w) - b * sin(w);
  }

  public float doFilter(float fin) {
    float in = fin;
    float result = 0.0;

    float out = (b0Bass * in + b1Bass * xn1Bass + b2Bass * xn2Bass - a1Bass * yn1Bass - a2Bass * yn2Bass ) / a0Bass;
    //println(a0Bass);
    xn2Bass = xn1Bass;
    xn1Bass = in;
    yn2Bass = yn1Bass;
    yn1Bass = out;
    //treble filter
    in = out;
    out = (b0Treble * in + b1Treble * xn1Treble + b2Treble * xn2Treble - a1Treble * yn1Treble - a2Treble * yn2Treble) / a0Treble;
    xn2Treble = xn1Treble;
    xn1Treble = in;
    yn2Treble = yn1Treble;
    yn1Treble = out;

    return out;
  }
}

public class TReverb {
  // int delay
  int delSample, mDelayMs = 128;
  float mDecay = 0.4;
  float mSampleRate = SAMPLE_RATE;
  ArrayList<Float> history;

  public TReverb() {
    initialize();
  }

  public void initialize() {
    delSample = (int)((float)mDelayMs * mSampleRate/1000);
    history = new ArrayList<Float>();
  }

  public float doFilter(float fin) {
    float in = fin;
    history.add(in);
    int idx = history.size()-1;
    float out = 0.0, prev;

    if ( idx >= delSample ) { 

      prev = history.get(idx-delSample);
      out = in + prev * mDecay;
    } else {
      out = in;
    }
    history.set(idx, out);
    return out;
  }
}