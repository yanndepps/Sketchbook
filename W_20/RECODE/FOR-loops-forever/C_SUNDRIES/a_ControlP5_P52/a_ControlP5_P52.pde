/* 
 --------------------------
 ** PLEASE READ INFO TAB **
 --------------------------
 
 */

/////////////////////////// GLOBALS ////////////////////////////
//Import ControlP5 Library
import controlP5.*;

//Declare an object for our interface
ControlP5 INTERFACES;
ControlFrame CW; // new window

int circleDiameter;
int xInterval, yInterval;
float thickness;

/////////////////////////// SETUP ////////////////////////////

void settings() {
  size(650, 450);
}

void setup() {
  
  background(255);
  smooth();
  noFill();  
  // Initialise Interface
  INTERFACES = new ControlP5(this); 
  // ADD NEW WINDOW
  CW = new ControlFrame(this, 400, 200, "Controls");
  surface.setLocation(420, 10);
}

/////////////////////////// DRAW ////////////////////////////
void draw() {
  background(255);

  for (int y = 75; y < height-50; y += yInterval) {       
    for (int x = 50; x < width-50; x += xInterval) {        
      stroke(0);
      strokeWeight( thickness );

      ellipse( x, y, circleDiameter, circleDiameter);
    }
  }
}

/////////////////////////// FUNCTIONS ////////////////////////////