/*
 * © thedotisblack
 * Type of images and sizes -> part_02
 * Transparent & Large Images
 */

PGraphics img;
int w = 3508;
int h = 3508;

void setup() {
  size(596, 596); // -> 297x297mm @ 72ppi
  // size(2448, 3508); // -> A4 @ 300ppi -> 2448x3508px
  img = createGraphics(w, h);
}

void draw() {
  background(#eeeeee);
  img.beginDraw();
  img.stroke(255);
  img.strokeWeight(10);
  img.fill(255, 0, 0);
  img.ellipse(random(img.width), random(img.height), 25, 25);
  img.endDraw();

  // please show me smth and scale it down to the display window
  image(img, 0, 0, width, height);
}

void keyPressed() {
  if (key == 's') {
    String timestamp = year()+"."+month()+"."+day()+"_"+hour()+"."+minute()+"."+second();
    // PGraphics does not work with saveFrame ... !
    img.save("images/" + timestamp + "_##.png");
    println("saved!");
  }
}
