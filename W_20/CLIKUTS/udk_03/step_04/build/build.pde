import processing.sound.*;
AudioIn input;
Amplitude amp;

void setup() {
    size(640, 480);
    amp= new Amplitude(this);
    input = new AudioIn(this, 0);  //mic or line in
    input.start();
    amp.input(input);
}
void draw() {
    int i= frameCount%height;
    stroke(amp.analyze()*255);
    line(0, i, width*0.5, i);  //change these values
    line(width*0.5, height-i, width, height-i);  //and these
}
