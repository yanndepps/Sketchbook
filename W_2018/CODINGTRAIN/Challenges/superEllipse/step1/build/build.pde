/*
*	SuperEllipse formulae
* step01 --> draw an ellipse using a bunch of points 
*/


int r = 200;				// radius

void setup() {
	size(640, 640);
	smooth();
}

void draw() {
	background(51);
	translate(width/2, height/2);
	stroke(255);
	noFill();

	// loop --> increment an angle and draw the points
	beginShape();
	for (float a = 0; a < TWO_PI; a += 0.01) {
		float x = r * cos(a);
		float y = r * sin(a);
		vertex(x, y);
	}
	endShape(CLOSE);
}
