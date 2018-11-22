import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

/*
*	SuperEllipse formulae
* 	step03 --> add controlP5 with external
* 	control window and sliders
*/


ControlFrame cf;

float a = 200;						// x axis radius
float b = 200;						// y axis radius
float n = 2;						// slider here ! from 0 to 10, starting at 2, 0.01 increment

//---

public void settings() {
	size(640, 640);
}

public void setup() {
	
	//controlP5
	cf = new ControlFrame(this, 400, 640, "Controls");
  	surface.setLocation(420, 10);

}

public void draw() {

	background(51);
	translate(width/2, height/2);
	stroke(200);
	fill(0xff666666);
	//
	beginShape();
	for (float angle = 0; angle < TWO_PI; angle += 0.1f) {

		float na = 2 / n;
		float x = pow(abs(cos(angle)), na) * a * sgn(cos(angle));
		float y = pow(abs(sin(angle)), na) * b * sgn(sin(angle));

		vertex(x, y);
	}
	endShape(CLOSE);
}

// evaluate if any value is positive or negative

public float sgn(float val) {

	if(val > 0) {
		return 1;
	} else if (val < 0) {
		return -1;
	} else {
		return 0;
	}

}

//------------- controlP5 ------------- //

class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setLocation(10, 10);
    cp5 = new ControlP5(this);



    cp5.addSlider(" n ")
       .plugTo(parent, "n")
       .setRange(0, 10)
       .setValue(2)
       .setPosition(10, 10)
       .setSize(330, 20);

  }
    public void draw() {
    background(51);
  }
}

//--- END
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
