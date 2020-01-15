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

int[] goodColors = {0xfff8f8f0, 0xffffcc00, 0xffedba00, 0xffe6db74, 0xffcccc99,
                      0xffa6e22e, 0xff8fbe00, 0xff79afa9, 0xff738c73, 0xff75715e, 0xff407886,
                      0xff37424A, 0xff00a8c6, 0xffaa6699, 0xffcc0033, 0xffda2000,
                      0xfff92672, 0xff967efb, 0xffa0a0a0};



public void setup() {
  
  background(0xffeeeeee);
  noLoop();
}


public void draw() {
  background(0xff313437);
  translate(width/2, height/2);
  for (int n = 0; n < 10; n++) {
    int bglen = goodColors.length;
    int rnd = (int)random(bglen);
    stroke(goodColors[rnd], 100);
    for (int a = 0; a < 360; a+=1) {
      float x = random(50, 150);
      float xx = random(150, 350);
      pushMatrix();
      rotate(radians(a));
      strokeCap(CORNER);
      strokeWeight(2);
      line(x, 0, xx, 0);
      popMatrix();
    }
  }
  saveFrame("frames/####.jpg");
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
