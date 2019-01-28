// Step12 : Polar Coordinates pt5 : pie graph

String filename = "results.csv";
String[] rawData;
float NSFtotal, NASAtotal;

void setup() {
  size(500, 500);
  rawData = loadStrings(filename);
  /* printArray(rawData); */
  processData();
}

void draw() {
  background(40);
  noStroke();

  // calculate the % of a grand total for each agency in radians.
  float NSFpos = calcRadians(NSFtotal);
  float NASApos = calcRadians(NASAtotal);
  float currPos = 0;

  // draw an arc based on % to our graph
  fill(255,0,0);
  arc(width/2, height/2, 400, 400, currPos, NSFpos);
  currPos += NSFpos;

  // push out dimensions to emphasize
  fill(255);
  arc(width/2, height/2, 425, 425, currPos, currPos + NASApos);

}

void processData() {
  for (int i = 0; i < rawData.length; i++) {
    String[] thisRow = split(rawData[i], ";");
    // printArray(thisRow);
    if (thisRow[2].contains("NSF")) {
      NSFtotal += float(thisRow[1]);
    } else if (thisRow[2].contains("NASA")) {
      NASAtotal += float(thisRow[1]);
    } else {
      println("ERROR " + i);
    }
  }
  println(NSFtotal);
  println(NASAtotal);
  println("DONE");
}

float calcRadians(float f) {
  // f = x% of grandTotal
  float percentage = (f / (NSFtotal + NASAtotal)) * 100;
  float arcPercent = (percentage/100) * 360;
  float arcRadians = radians(arcPercent);
  return arcRadians;
}
