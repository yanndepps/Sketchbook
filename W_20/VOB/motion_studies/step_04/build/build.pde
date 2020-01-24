// Visions of the Bauhaus
// Motion Studies in Space : 04

/*
  Line relationships and their plane-forming effect
  are explored.
*/


void setup() {
  size(800, 800, P2D);
  frameRate(5);
  noFill();
}

void draw() {
  background(255);
  strokeCap(SQUARE);
  strokeWeight(random(200));
  line(random(25, width-25), random(25, height-25), 
        random(25, width-25),random(25, height-25));
  strokeWeight(random(800));
  arc(random(0, width), random(0, height), random(200, width-200),
      random(200, height-200), random(0, 2*PI), random(0, 2*PI));
}
