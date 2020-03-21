// Vera Molnar : Square Structure 01

color[] colArray = {
	color(255,255,255),  // white
	color(210,81,94),    // marine red
	color(57,126,88),    // grass
	color(73,130,207),   // sky blue
	color(0,116,162),    // sea blue
	color(187,118,207),  // purple
	color(255,232,0)     // yellow
};

int margin = 150;
int grid   = 100;

void setup() {
	size(800, 800);
	noLoop();
}

void draw() {
	background(15, 20, 30);
	noFill();
	stroke(255);

	float d = grid*0.6;

	for (int i = margin; i <= width-margin; i += grid) {
		for (int j = margin; j <= height-margin; j += grid) {

			int colArrayNum = (int)random(7);
			stroke(colArray[colArrayNum]);
			strokeWeight(1);

			for (int num = 0; num < 3; num++) {
				float x1 = -random(d);
				float y1 = -random(d);
				float x2 = random(d);
				float y2 = -random(d);
				float x3 = random(d);
				float y3 = random(d);
				float x4 = -random(d);
				float y4 = random(d);

				pushMatrix();
				translate(i, j);
				quad(x1, y1, x2, y2, x3, y3, x4, y4);
				popMatrix();
			}
		}
	}
}

void keyPressed() {
	if (key == ' ') redraw();
}