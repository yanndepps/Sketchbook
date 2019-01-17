// Step10 : Polar Coordinates pt3

String filename = "results.csv";
String[] rawData;

void setup() {
  rawData = loadStrings(filename);
  /* printArray(rawData); */
  processData();
}

void draw() {
}

void processData() {
  for (int i = 0; i < rawData.length; i++) {
    if (!rawData[i].contains("NSF") && !rawData[i].contains("NASA")) {
      println(rawData[i]);
    }
  }
  println("Done !");
}
