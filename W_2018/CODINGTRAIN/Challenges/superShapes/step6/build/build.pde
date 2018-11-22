/*
	step6 ---> add controls and move to torus instead of sphere
*/


// --- INIT --- //
import controlP5.*;
import  peasy.*;

ControlFrame cf;
PeasyCam cam;
PVector[][] globe;

// sliders values
float sl1a = 0;
float sl2a = 0;
float sl3a = 0;
float slm1 = 1;
float sl1b = 0;
float sl2b = 0;
float sl3b = 0;
float slm2 = 1;
float sla1 = 1;
float sla2 = 1;
float slb1 = 1;
float slb2 = 1;
int res = 125;
float xscaleFactor = 1.0;
float yscaleFactor = 1.0;
float zscaleFactor = 1.0;
float startPI = -PI;
float endPI = PI;
float startTPI = 0;
float endTPI = 1000;	// TWO_PI

// --- SETUPS --- //

void settings() {
	size(800, 800, P3D);
}

void setup() {
	cam = new PeasyCam(this, 500);
	globe = new PVector[res+1][res+1];
	colorMode(HSB);
	smooth();
	//controlP5
	cf = new ControlFrame(this, 400, 640, "Controls");
  surface.setLocation(420, 10);
}

// that function returns a radius value
float supershape1(float theta, float m, float n1, float n2, float n3) {
	float t1 = abs((1 / sla1) * cos(m * theta / 4));
	t1 = pow(t1, n2);
	float t2 = abs((1 / slb1) * sin(m * theta / 4));
	t2 = pow(t2, n3);
	float t3 = t1 + t2;
	float r = pow(t3, -1 / n1);
	return r;
}

float supershape2(float theta, float m, float n1, float n2, float n3) {
	float t1 = abs((1 / sla2) * cos(m * theta / 4));
	t1 = pow(t1, n2);
	float t2 = abs((1 / slb2) * sin(m * theta / 4));
	t2 = pow(t2, n3);
	float t3 = t1 + t2;
	float r = pow(t3, -1 / n1);
	return r;
}


// --- DRAW --- //

void draw() {
	// m = map(sin(mchange), -1, 1, 0, 7);
	// mchange += 0.025;
  background(51);
	noStroke();
  lights();
	float r = 200;
	for (int i = 0; i < res+1; i++) {
		float lat = map(i, 0, res, startPI, endPI);
		float r2 = supershape2(lat, slm2, sl1b, sl2b, sl3b);	  			// radius for the first supershape based on latitude
		for (int j = 0; j < res+1; j++) {
			float lon = map(j, 0, res, startTPI, endTPI);
			float r1 = supershape1(lon, slm1, sl1a, sl2a, sl3a);			// radius for the second supershape based on longitude
			// float x = r * r1 * cos(lon) * r2 * cos(lat);
			float x = cos(lon)*(r*r1+r*r2*cos(lat))  * xscaleFactor;
			// float y = r * r1 * sin(lon) * r2 * cos(lat);
			float y = sin(lon)*(r*r1+r*r2*cos(lat))  * yscaleFactor;
			float z = r * r2 * sin(lat) * zscaleFactor;
			globe[i][j] = new PVector(x, y, z);
		}
	}

	stroke(255, 100);
	// noFill();
	fill(155);
	// offset += 5;
	for (int i = 0; i < res; i++) {
		// float hu = map(i, 0, res, 0, 255*6);		// gradient effect
		// fill(hu % 255, 255, 255);
		beginShape(TRIANGLE_STRIP);
		for (int j = 0; j < res+1; j++) {
			PVector v1 = globe[i][j];
			vertex(v1.x, v1.y, v1.z);
			PVector v2 = globe[i+1][j];
			vertex(v2.x, v2.y, v2.z);
		}
		endShape();
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



    cp5.addSlider(" sl1a ")
       .plugTo(parent, "sl1a")
       .setRange(-100, 100)
       .setValue(-0.68)
       .setPosition(10, 10)
       .setSize(330, 20);


    cp5.addSlider(" sl2a ")
   		.plugTo(parent, "sl2a")
   		.setRange(-100, 100)
   		.setValue(22.77)
   		.setPosition(10, 40)
   		.setSize(330, 20);


   	cp5.addSlider(" sl3a ")
       .plugTo(parent, "sl3a")
       .setRange(-100, 100)
       .setValue(0.75)
       .setPosition(10, 70)
       .setSize(330, 20);

    cp5.addSlider(" sl1b ")
       .plugTo(parent, "sl1b")
       .setRange(-100, 100)
       .setValue(15.24)
       .setPosition(10, 100)
       .setSize(330, 20);


    cp5.addSlider(" sl2b ")
   		.plugTo(parent, "sl2b")
   		.setRange(-100, 100)
   		.setValue(0.35)
   		.setPosition(10, 130)
   		.setSize(330, 20);


   	cp5.addSlider(" sl3b ")
       .plugTo(parent, "sl3b")
       .setRange(-100, 100)
       .setValue(49.59)
       .setPosition(10, 160)
       .setSize(330, 20);

   	cp5.addSlider(" slm1 ")
       .plugTo(parent, "slm1")
       .setRange(0, 12)
       .setValue(6)
       .setPosition(10, 190)
       .setSize(330, 20);

   	cp5.addSlider(" slm2 ")
       .plugTo(parent, "slm2")
       .setRange(0, 12)
       .setValue(3)
       .setPosition(10, 220)
       .setSize(330, 20);

   	cp5.addSlider(" sla1 ")
       .plugTo(parent, "sla1")
       .setRange(0, 3)
       .setValue(1)
       .setPosition(10, 250)
       .setSize(330, 20);

   	cp5.addSlider(" sla2 ")
       .plugTo(parent, "sla2")
       .setRange(0, 3)
       .setValue(1)
       .setPosition(10, 280)
       .setSize(330, 20);

   	cp5.addSlider(" slb1 ")
       .plugTo(parent, "slb1")
       .setRange(0, 3)
       .setValue(1)
       .setPosition(10, 310)
       .setSize(330, 20);

   	cp5.addSlider(" slb2 ")
       .plugTo(parent, "slb2")
       .setRange(0, 3)
       .setValue(1)
       .setPosition(10, 340)
       .setSize(330, 20);

   	cp5.addSlider(" res ")
       .plugTo(parent, "res")
       .setRange(25, 125)
       .setValue(125)
       .setPosition(10, 370)
       .setSize(330, 20);

   	cp5.addSlider(" XSF ")
       .plugTo(parent, "xscaleFactor")
       .setRange(0.0, 1.0)
       .setValue(1)
       .setPosition(10, 400)
       .setSize(330, 20);

   	cp5.addSlider(" YSF ")
       .plugTo(parent, "yscaleFactor")
       .setRange(0.0, 1.0)
       .setValue(1)
       .setPosition(10, 430)
       .setSize(330, 20);

   	cp5.addSlider(" ZSF ")
       .plugTo(parent, "zscaleFactor")
       .setRange(0.0, 1.0)
       .setValue(1)
       .setPosition(10, 460)
       .setSize(330, 20);

   	cp5.addSlider(" PI ")
       .plugTo(parent, "startPI")
       .setRange(-PI, PI)
       .setValue(-PI)
       .setPosition(10, 490)
       .setSize(330, 20);

   	cp5.addSlider(" 2PI ")
       .plugTo(parent, "startTPI")
       .setRange(0, endTPI)
       .setValue(0)
       .setPosition(10, 520)
       .setSize(330, 20);

  }


    void draw() {
    background(51);
  }

}








// --- END --- //
