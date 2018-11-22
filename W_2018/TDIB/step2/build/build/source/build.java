import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {





public void setup() {
  
  background(0xffeeeeee);
  noLoop();
}


public void draw() {
  background(0xffeeeeee);
  translate(width/2, height/2);
  for (int a = 0; a < 360; a+=1) {
    float x = random(50, 150);
    float xx = random(150, 350);
    pushMatrix();
    rotate(radians(a));
    strokeCap(CORNER);
    strokeWeight(4);
    stroke(40);
    line(x, 0, xx, 0);
    popMatrix();
  }
}

public void keyPressed() {
  redraw();
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
