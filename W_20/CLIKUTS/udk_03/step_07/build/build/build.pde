//filter graphics
import processing.sound.*;
AudioIn input;
AudioDevice device;
FFT fft;
final int bands = 128;
float step;
PGraphics pg;

void setup() {
    size(640, 480);
    device = new AudioDevice(this, 44100, bands);
    input = new AudioIn(this, 0);  //mic or line in left
    input.start();
    fft = new FFT(this, bands);
    fft.input(input);
    pg= createGraphics(bands, bands);
}
void draw() {
    fft.analyze();
    pg.beginDraw();
    for (int i = 0; i < bands; i++) {
        float val= fft.spectrum[bands-1-i];   //draw lowest frequencies at the bottom
        pg.stroke(min(255, val*1000));
        pg.line(0, i, bands, i);
    }
    pg.endDraw();
    pg.filter(BLUR, 2);
    image(pg, 0, 0, width, height);  //stretch out pg to fill full window
}
