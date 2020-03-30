//real2
import processing.sound.*;
AudioIn input0, input1;
AudioDevice device;
FFT fft0, fft1;
final int bands = 128;
float step;

void setup() {
    size(640, 480);
    device = new AudioDevice(this, 44100, bands);
    input0 = new AudioIn(this, 0);  //mic or line in left
    input1 = new AudioIn(this, 1);  //mic or line in right
    input0.start();
    input1.start();
    fft0 = new FFT(this, bands);
    fft0.input(input0);
    fft1 = new FFT(this, bands);
    fft1.input(input1);
    step= height/float(bands);  //line width
    strokeWeight(step);
}
void draw() {
    fft0.analyze();
    fft1.analyze();
    for (int i = 0; i < bands; i++) {
        float val0= fft0.spectrum[bands-1-i];   //draw lowest frequencies at the bottom
        stroke(min(255, val0*1000));    //boost values and clip at 255
        line(0, i*step, width*0.5, i*step);
        float val1= fft1.spectrum[bands-1-i];   //draw lowest frequencies at the bottom
        stroke(min(255, val1*1000));
        line(width*0.5, i*step, width, i*step);
    }
}
