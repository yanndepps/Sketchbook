/*
  spherical geometry --> step1 using
  the buildin function
*/


void settings() {
	size(640, 640, P3D);
}

void setup() {

}

void draw() {
  background(51);
  fill(255);
  lights();
  translate(width/2, height/2);
  sphere(200);

}
