import processing.video.*;
final int numDelays= 4;  //try changing this
PImage img;
Capture cam;
void setup() {
    size(800, 480);
    cam = new Capture(this, width, height);
    cam.start();
    img= createImage(width, height, RGB);
}
void draw() {
    if (cam.available()) {
        cam.read();
        int slotWidth= width/(numDelays+1);
        for (int i= numDelays; i>0; i--) {
            img.copy(img, slotWidth*(i-1), 0, slotWidth, height, slotWidth*i, 0, slotWidth, height);
        }
        img.copy(cam, 0, 0, slotWidth, height, 0, 0, slotWidth, height); 
        image(img, 0, 0);
    }
}
