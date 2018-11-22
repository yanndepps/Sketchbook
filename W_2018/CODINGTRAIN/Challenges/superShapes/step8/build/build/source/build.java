import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import peasy.*; 

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
	step6 ---> add controls
*/


// --- INIT --- //


PeasyCam cam;
PVector[][] globe;
int total = 75;		      // mesh resolution
// float offset = 0;
// float mchange = 0;
float m1 = 6;
float m2 = 6;
float a = 1;
float b = 1;

// --- SETUPS --- //

public void settings() {
	size(800, 800, P3D);
}

public void setup() {
	cam = new PeasyCam(this, 500);
	globe = new PVector[total+1][total+1];
	colorMode(HSB);
}

// that function returns a radius value
public float supershape(float theta, float m, float n1, float n2, float n3) {
	float t1 = abs((1 / a) * cos(m * theta / 4));
	t1 = pow(t1, n2);
	float t2 = abs((1 / b) * sin(m * theta / 4));
	t2 = pow(t2, n3);
	float t3 = t1 + t2;
	float r = pow(t3, -1 / n1);
	return r;
}


// --- DRAW --- //

public void draw() {
	// m = map(sin(mchange), -1, 1, 0, 7);
	// mchange += 0.025;
  background(51);
	noStroke();
  lights();
	float r = 200;
	for (int i = 0; i < total+1; i++) {
		float lat = map(i, 0, total, -HALF_PI, HALF_PI);
		float r2 = supershape(lat, m2, 250, 100, 100);	  			// radius for the first supershape based on latitude
		for (int j = 0; j < total+1; j++) {
			float lon = map(j, 0, total, -PI, PI);
			float r1 = supershape(lon, m1, 60, 55, 1000);			// radius for the second supershape based on longitude
			float x = r * r1 * cos(lon) * r2 * cos(lat);
			float y = r * r1 * sin(lon) * r2 * cos(lat);
			float z = r * r2 * sin(lat);
			globe[i][j] = new PVector(x, y, z);
		}
	}

	stroke(255, 100);
	// noFill();
	fill(99);
	// offset += 5;
	for (int i = 0; i < total; i++) {
		// float hu = map(i, 0, total, 0, 255*6);		// gradient effect
		// fill(hu % 255, 255, 255);
		beginShape(TRIANGLE_STRIP);
		for (int j = 0; j < total+1; j++) {
			PVector v1 = globe[i][j];
			vertex(v1.x, v1.y, v1.z);
			PVector v2 = globe[i+1][j];
			vertex(v2.x, v2.y, v2.z);
		}
		endShape();
	}
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
