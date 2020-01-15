// Step11 : Polar Coordinates pt4

String filename = "results.csv";
String[] rawData;
float NSFtotal, NASAtotal;

void setup() {
  rawData = loadStrings(filename);
  /* printArray(rawData); */
  processData();
}

void draw() {
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
