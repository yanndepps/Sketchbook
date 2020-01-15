/*
  spherical geometry --> step5
	add some jiggle to the points
*/


import  peasy.*;
PeasyCam cam;
PVector[][] globe;
int total = 20;

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
		float lat = map(i, 0, total, -HALF_PI, HALF_PI);
		for (int j = 0; j < total+1; j++) {
			float lon = map(j, 0, total, -PI, PI);
			float x = r * sin(lon) * cos(lat);
			float y = r * sin(lon) * sin(lat);
			float z = r * cos(lon);
			globe[i][j] = new PVector(x, y, z);
			// jiggle
			PVector v = PVector.random3D();
			v.mult(10);
			globe[i][j].add(v);
		}
	}

	for (int i = 0; i < total; i++) {
		beginShape(TRIANGLE_STRIP);
		for (int j = 0; j < total+1; j++) {
			float hu = map(j, 0, total, 0, 255*6);
			fill(hu % 255, 255, 255);
			PVector v1 = globe[i][j];
			vertex(v1.x, v1.y, v1.z);
			PVector v2 = globe[i+1][j];
			vertex(v2.x, v2.y, v2.z);
		}
		endShape();
	}
}
