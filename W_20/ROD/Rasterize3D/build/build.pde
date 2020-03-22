PImage img;

void setup() {
  size(800, 800, P3D);
  img = loadImage("venus.jpg");
  img.resize(800, 800);
}

void draw() {
  background(#f1f1f1);
  noStroke();
  fill(0);
  sphereDetail(3);

  float tiles = 100;
  float tileSize = width/tiles;

  push();
  translate(width/2, height/2);
  // rotateY(radians(frameCount*0.5));
  rotateY(radians(map(mouseX, 0, width, 0, 180)));
  for (int x = 0; x < tiles; x++) {
  	for (int y = 0; y < tiles; y++) {
  		color c = img.get(int(x*tileSize), int(y*tileSize));
  		float b = map(brightness(c), 0, 255, 1, 0);
  		float z = map(b, 0, 1, -150, 150);
  		push();
  		translate(x*tileSize-width/2, y*tileSize-height/2, z);
  		sphere(tileSize*b*0.8);
  		pop();
  	}
  }
  pop();
}
