/*
  spherical geometry --> step6
	epilogue : fix the color mapping issue
*/


import  peasy.*;
PeasyCam cam;
PVector[][] globe;
int total = 200;

void settings() {
	size(640, 640, P3D);
}

void setup() {
	cam = new PeasyCam(this, 500);
	globe = new PVector[total+1][total+1];
	colorMode(HSB);
}

void draw() {
  background(51);
	noStroke();
  lights();
	float r = 200;
	for (int i = 0; i < total+1; i++) {
		float lat = map(i, 0, total, 0, PI);
		for (int j = 0; j < total+1; j++) {
			float lon = map(j, 0, total, 0, TWO_PI);
			float x = r * sin(lat) * cos(lon);
			float y = r * sin(lat) * sin(lon);
			float z = r * cos(lat);
			globe[i][j] = new PVector(x, y, z);
		}
	}

	for (int i = 0; i < total; i++) {
		// float hu = map(i, 0, total, 0, 255*6);		// rainbow effect
		// fill(hu % 255, 255, 255);
		float hu = map(i, 0, total, 0, 255);		// gradient effect 
		fill(hu, 255, 255);
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
