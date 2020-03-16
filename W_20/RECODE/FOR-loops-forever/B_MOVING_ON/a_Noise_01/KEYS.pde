/////////////////////////// FUNCTIONS ////////////////////////////
// SOME KEY INTERACTIONS THAT ENABLE US TO CHANGE OUR VARIABLES
// AND THEREFORE CHANGE OUR VISUAL IN REAL TIME

void keyPressed() {
  // Activate/disactivate animation
  if (key == 'p') {
    animate =!animate;
  }
  // Increase the size of our cirlces
  if (key == '+') {
    circleDiameter += 2;
  }

  // Decrease the size of our cirlces
  if (key == '-') {
    circleDiameter -= 2;
  }

  // Increase the y interval of our grid
  if (keyCode == UP) {
    yInterval += 2;
  }

  // Decrease the y interval of our grid
  if (keyCode == DOWN) {
    yInterval -= 2;
  }

  // Increase the x interval of our grid
  if (keyCode == RIGHT) {
    xInterval += 2;
  }

  // Decrease the x interval of our grid
  if (keyCode == LEFT) {
    xInterval -= 2;
  }

  // Increase the x interval of our grid
  if (key == 'w') {
    thickness += 0.5;
  }

  // Decrease the x interval of our grid
  if (key == 'x') {
    thickness -= 0.5;
  }
}

