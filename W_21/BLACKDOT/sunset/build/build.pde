// declare an array to create a list of data for the y-values
int num = 50;
float[] y = new float[num];
float sW;

void setup() {
  // ...
  size(700, 700);
  surface.setLocation(350, 10);
  // fullScreen();
  // to see something, we need to assign data to each array element.
  // or store y-values in the array list that we can display in draw
  for (int n = 0; n < num; n++) {
    y[n] = height/num*n;
  }
  // the thickness of the lines should change according to the number of
  // lines or the length of the array
  sW = height/num/2;
}

void draw() {
  background(#061324);
  // use a for loop to vertically distribute a horizontal line
  for (int n = 0; n < num; n++) {
    // color: assign transparency to each array element
    // transparency depends on the y-value of each line
    float alpha = map(y[n], 0, height, 0, 255);
    stroke(#f10000, alpha);
    strokeWeight(sW);
    line(0, y[n], width, y[n]);
    // add vertical movement to each array element
    // if the y-value becomes larger than the height, reset it to 0.
    y[n] += 0.5;
    if (y[n] > height) y[n] = 0;
  }
  // add an ellipse to use as a mask
  stroke(#061324);
  strokeWeight(height/3);
  noFill();
  ellipse(width/2, height/2, height+height/6, height+height/6);
}

