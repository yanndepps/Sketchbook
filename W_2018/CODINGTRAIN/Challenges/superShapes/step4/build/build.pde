/*
	step4 ---> animate the hue
*/


// --- INIT --- //

import  peasy.*;
PeasyCam cam;
PVector[][] globe;
int total = 75;		      // mesh resolution
float offset = 0;
float a = 1;
float b = 1;

// --- SETUPS --- //

void settings() {
	size(640, 640, P3D);
}

void setup() {
	cam = new PeasyCam(this, 500);
	globe = new PVector[total+1][total+1];
	colorMode(HSB);
}

// that function returns a radius value
float supershape(float theta, float m, float n1, float n2, float n3) {
	float t1 = abs((1 / a) * cos(m * theta / 4));
	t1 = pow(t1, n2);
	float t2 = abs((1 / b) * sin(m * theta / 4));
	t2 = pow(t2, n3);
	float t3 = t1 + t2;
	float r = pow(t3, -1 / n1);
	return r;
}


// --- DRAW --- //

void draw() {
  background(51);
	noStroke();
    lights();
	float r = 200;
	for (int i = 0; i < total+1; i++) {
		float lat = map(i, 0, total, -HALF_PI, HALF_PI);                            
		float r2 = supershape(lat, 2, 10, 10, 10);	  			// radius for the first supershape based on latitude						
		for (int j = 0; j < total+1; j++) {
			float lon = map(j, 0, total, -PI, PI);
			float r1 = supershape(lon, 8, 60, 100, 30);			// radius for the second supershape based on longitude
			float x = r * r1 * cos(lon) * r2 * cos(lat);
			float y = r * r1 * sin(lon) * r2 * cos(lat);
			float z = r * r2 * sin(lat);
			globe[i][j] = new PVector(x, y, z);
		}
	}

	stroke(255, 100);
	// noFill();
	// fill(255);
	offset += 5;
	for (int i = 0; i < total; i++) {
		float hu = map(i, 0, total, 0, 255*6);		// gradient effect 
		fill((hu + offset) % 255, 255, 255);
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
