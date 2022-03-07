/*
 * the map() function -> recap
 * map() allows you to move a given range of values into a new range of values.
 * The function takes 5 parameters.
 * The first parameter is the input value to be converted.
 * Parameters 2 and 3 define the minimum and maximum value of the original value range.
 * Parameters 4 and 5 define the minimum and maximum value of the desired value range.
 */

void setup() {
  size(640, 640);
  background(0);
  fill(#f4f4f4);
  noStroke();
}

void draw () {
  translate(width/2, 0);
  float h = height/3;
  float wave_1 = sin(radians(frameCount)) * width/2;
  rect(wave_1, 0, 25, h);

  float wave_2 = map(sin(radians(frameCount)), -1, 1, 30, 300);
  rect(wave_2, h, 25, h);

  float wave_3 = map(sin(radians(frameCount)), -1, 1, -width/2, 0);
  rect(wave_3, h*2, 25, h);
}
