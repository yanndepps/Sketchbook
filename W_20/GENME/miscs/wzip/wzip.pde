// wzip - a preprocessor for lossy data compression, originally: Copyright (C) 1997 Andreas Franzen
// Processing port, Tomasz Sulej, generatene.blog@gmail.com
// Haar wavelet transformation to glitch your raw images, operates on bytes, use different scaling factors (see below)

import java.io.BufferedOutputStream;
import java.io.DataOutputStream;

// CONFIGURATION, change here
String filename = "file.raw"; // file name of your raw, result saved to "res_"+filename
float scalingfactorin = 100; // compression ratio (any float)
float scalingfactorout = 40; // decompression ratio (any float)
// DO NOT TOUCH BELOW THIS LINE

final static float sqrt05 = sqrt(0.5);

void setup() {
  byte[] raw = loadBytes(filename);
  
  int n = (int)pow(2,ceil(log(raw.length)/log(2)));
  
  println("compress");
  
  float[] y = new float[n];
  float[] w = new float[n];
  
  //compress
  for(int i=0;i<raw.length;i++) y[i] = raw[i];
  for(int i=raw.length;i<n;i++) y[i] = raw[raw.length-1];
  
  wtrafo(y,w,n);
  
  for(int i=0;i<n-1;i++) y[i] = (int)(w[i]/scalingfactorin);
  if(w[n-1]>0) y[n-1] = (int)(w[n-1]/scalingfactorin+0.5);
  else y[n-1] = (int)(w[n-1]/scalingfactorin-0.5);
  
  println("decompress");
  
  //decompress
  wbtrafo(y,w,n);
  
  for(int i=0;i<raw.length;i++) raw[i] = byte(w[i]*scalingfactorout);
  
  println("done");
  saveBytes("res_"+filename,raw);
}

void wbtrafo(float[] y, float[] w, int n) {
  float[] d = new float[n];
  d[n-2] = y[n-1];
  int b1 = n-4;
  int b2 = n-2;
  int a=1;
  while(a<n/2) {
    for(int i=0;i<a;i++) {
      d[2*i+b1]=(d[i+b2]+y[i+b2])*sqrt05;
      d[2*i+1+b1]=(d[i+b2]-y[i+b2])*sqrt05;
    }
    b2=b1;
    b1=b1-4*a;
    a*=2;
  }
  
  for(int i=0;i<a;i++) {
      w[2*i]=(d[i]+y[i])*sqrt05;
      w[2*i+1]=(d[i]-y[i])*sqrt05;
  }
}

void wtrafo(float[] y, float[] w, int n) {
  float[] d = new float[n];
  int a = n/2;
  for(int i=0;i<a;i++) {
    w[i] = (y[2*i]-y[2*i+1])*sqrt05;
    d[i] = (y[2*i]+y[2*i+1])*sqrt05;
  }
  int b1 = 0;
  int b2 = a;
  a/=2;
  while(a>0) {
    for(int i=0;i<a;i++) {
      w[i+b2]=(d[2*i+b1]-d[2*i+1+b1])*sqrt05;
      d[i+b2]=(d[2*i+b1]+d[2*i+1+b1])*sqrt05;
    }
    b1=b2;
    b2=b2+a;
    a/=2;
  }
  w[b2] = d[b1];
}
