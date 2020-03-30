//real3
import processing.sound.*;
AudioIn input0, input1;
AudioDevice device;
FFT fft0, fft1;
final int bands = 128;
float step;

void setup() {
    size(640, 480);
    device = new AudioDevice(this, 44100, bands);
    input0 = new AudioIn(this, 0);  //mic or line in
    input1 = new AudioIn(this, 1);  //mic or line in
    input0.start();
    input1.start();
    fft0 = new FFT(this, bands);
    fft0.input(input0);
    fft1 = new FFT(this, bands);
    fft1.input(input1);
    step= height/float(bands);
    strokeWeight(step);
}
void draw() {
    background(0);
    fft0.analyze();
    fft1.analyze();
    for (int i = 0; i < bands; i++) {
        float val0= fft0.spectrum[i];
        stroke(min(255, val0*1000));
        line(0, height*0.5+i, width*0.5, height*0.5+i);  //play with these numbers
        line(0, height*0.5-i, width*0.5, height*0.5-i);  //and these
        float val1= fft1.spectrum[i];
        stroke(min(255, val1*1000));
        line(width*0.5, height*0.5+i, width, height*0.5+i);  //here too
        line(width*0.5, height*0.5-i, width, height*0.5-i);  //and here
    }
}
