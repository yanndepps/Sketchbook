// Step09 : Polar Coordinates pt2

float bananas = 15;
float apples = 60;
float pears = 100 - (apples + bananas);

void setup() {
  size(500, 500);
  background(40);
  noStroke();

  // calc % of 1 revolution for each fruit
  float bPos = calcRadians(bananas);
  float aPos = calcRadians(apples);
  float pPos = calcRadians(pears);

  float currPos = 0;
  fill(255, 0, 0);
  arc(width/2, height/2, 400, 400, currPos, bPos);
  currPos += bPos;

  fill(0, 255, 0);
  arc(width/2, height/2, 400, 400, currPos, currPos + aPos);
  currPos += aPos;

  fill(0, 0, 255);
  arc(width/2, height/2, 400, 400, currPos, currPos + pPos);
}

void draw() {

}

float calcRadians(float f) {
  float arcPercent = (f/100) * 360;
  float arcRadians = radians(arcPercent);
  return arcRadians;
}
