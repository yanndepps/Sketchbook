/*
 * © thedotisblack
 * Type of images and sizes -> part_01
 */

void setup() {
  // size(842, 842); // -> 297x297mm @ 72ppi
  size(2448, 3508); // -> A4 @ 300ppi -> 2448x3508px
  strokeCap(CORNER);
  // noLoop();
}

void draw() {
  background(#EEEEEE);
  translate(width/2, height/2);
  for (float angle = 90; angle <= 450; angle += 1) {
    float x = random(250, 300);
    pushMatrix();
    rotate(radians(angle));
    stroke(222, 0, 0);
    strokeWeight(4);
    line(x, 0, width, 0);
    popMatrix();
  }
}

void keyPressed() {
  if (key == 's') {
    // save("firstImage.png");
    // saveFrame("firstImage_##.png");
    String timestamp = year()+"."+month()+"."+day()+"_"+hour()+"."+minute()+"."+second();
    saveFrame("images/" + timestamp + "_##.png");
    println("saved!");
  }
}
