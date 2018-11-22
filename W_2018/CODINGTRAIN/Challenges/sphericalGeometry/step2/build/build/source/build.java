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
  spherical geometry --> step2 map the longitude (-180 to 180 degrees)
	and the latitude (-90 to 90 degrees) within a loop
*/



PeasyCam cam;

public void settings() {
	size(640, 640, P3D);

}

public void setup() {
	cam = new PeasyCam(this, 200);
}

public void draw() {
  background(51);
  fill(255);
  lights();
  // translate(width/2, height/2);
  // what is my sphere detail level (how many points)
	float r = 200;
	int total = 100;
	for (int i = 0; i < total; i++) {
		float lon = map(i, 0, total, -PI, PI);
		for (int j = 0; j < total; j++) {
			float lat = map(j, 0, total, -HALF_PI, HALF_PI);
			float x = r * sin(lon) * cos(lat);
			float y = r * sin(lon) * sin(lat);
			float z = r * cos(lon);
			stroke(255);
			strokeWeight(4);
			point(x, y, z);
		}
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
