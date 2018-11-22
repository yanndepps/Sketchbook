/*
*	SuperEllipse formulae
* 	step02 --> draw the same circle but 
* 	using the superformule
*/


float a = 200;				
float b = 200;
float n = 1.4;						// slider here ! from 0 to 10, starting at 2, 0.01 increment

//---

void setup() {
	size(640, 640);
	smooth();
}

void draw() {
	background(51);
	translate(width/2, height/2);
	stroke(200);
	noFill();

	// 
	beginShape();
	for (float angle = 0; angle < TWO_PI; angle += 0.1) {

		float na = 2 / n;
		float x = pow(abs(cos(angle)), na) * a * sgn(cos(angle));
		float y = pow(abs(sin(angle)), na) * b * sgn(sin(angle));

		vertex(x, y);
	}
	endShape(CLOSE);
}

// evaluate if any value is positive or negative

float sgn(float val) {

	if(val > 0) {
		return 1;
	} else if (val < 0) {
		return -1;
	} else {
		return 0;
	}

}

//---