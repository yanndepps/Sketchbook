// http://generateme.tumblr.com
// Harmonograph with noise

// space - save
// click - change

float time;
float f1,f2,f3,f4;
float p1,p2,p3,p4;
float a1,a2,a3,a4;
float d1,d2,d3,d4;
float nscale;

float[] freqs;

void setup() {
  size(600, 600);
  smooth(8);
  background(20);
  stroke(220, 10);
  noFill();
  
  freqs = new float[21];
  for(int i=-10;i<=10;i++) {
    freqs[i+10] = 4*i/10.0;
  }
  
  renew();
}

void renew() {
  background(20);
  // freqs
  f1 = freqs[(int)random(freqs.length)];
  f2 = freqs[(int)random(freqs.length)];
  f3 = freqs[(int)random(freqs.length)];
  f4 = freqs[(int)random(freqs.length)];

  // phases
  p1 = randomGaussian();
  p2 = randomGaussian();
  p3 = randomGaussian();
  p4 = randomGaussian();

  // amplitudes
  a1 = random(280);
  a2 = random(280-a1);
  a3 = random(280);
  a4 = 280-a3;

  // damp
  d1 = 0.0001 * (random(1)<0.1 ? 1.0 : 0.0);
  d2 = 0.0;
  d3 = 0.0001 * (random(1)<0.1 ? 1.0 : 0.0);
  d4 = 0.0;

  time = 0.0;
  nscale = random(100,600);
  noiseSeed((int)random(MAX_INT));
}


void draw() {
  for (int i=0; i<10000; i++) {
    float x = 
      exp(-time * d1) * a1 * sin(f1 * time + TWO_PI*noise(1.0, time, p1) + p1) +
      exp(-time * d2) * a2 * sin(f2 * (noise(sin(time*f2),f2)+time) + p2);
    float y = 
      exp(-time * d3) * a3 * sin(f3 * time + p3) +
      exp(-time * d4) * a4 * sin(f4 * time + TWO_PI*noise(x/nscale, p4) + p4);

    point(x+300, y+300);

    time += 0.01;
  }
}

void mouseClicked() {
  renew();
}

void keyPressed() {
  saveFrame(hex((int)random(0xffff),4)+"######.jpg");
  println("Saved");
}