import processing.video.*;
Capture cam;
void setup() {
    size(800, 800);
    cam = new Capture(this, width, height);
    cam.start();
    background(0);
}
void draw() {
    if (cam.available()) {
        cam.read();
        translate(width*0.5, height*0.5);
        rotate(frameCount* -0.005);  //rotation speed
        scale(1, 0.1);
        translate(-width*0.5, -height*0.5);
        image(cam, 0, 0);
    }
}
