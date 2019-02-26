// the nature of code : simulating natural systems : random walk : step_01
// how do we change an object location over time ?
// OOP is data and functionality together
// four directions each with equal probabilty (25%)

Walker w;

void setup() {
  size(512, 512);
  background(33);
  w = new Walker();
}

void draw() {
  w.step();
  w.render();
}
