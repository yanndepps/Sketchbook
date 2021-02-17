/*
 * moiré patterns
 * step 01
 */

float xStep = 20;
float xx;
float angle = 5;

void setup() {
  size(700, 700);
  surface.setLocation(350, 15);
  
  // style
  stroke(255);
  strokeCap(CORNER);
  strokeWeight(xStep/2);

}

void draw() {
  background(255);
  // create difference with blendMode() and substract
  // the lines from each other
  // both lines and background must have the same color
  blendMode(DIFFERENCE);

  // xx = map(mouseX, 0, width, -width/2, width/2);
  // angle = map(mouseY, 0, height, -90, 90);
  // change number of lines with the mouse
  xStep = map(mouseY, 0, height, 10, height);

  strokeWeight(xStep/2);
  // origin to the center of the screen
  translate(width/2, height/2);
  // vertical lines along the x-axis
  for (int x = -width/2; x <= +width/2; x += xStep) {
    line(x, -height/2, x, height/2);
  }

  // second set of vertical lines
  // changes its position with the mouse
  rotate(radians(angle));
  for (int x = -width/2; x <= +width/2; x += xStep) {
    line(x + xx, -height/2, x + xx, height/2);
  } 
  angle++;
}
