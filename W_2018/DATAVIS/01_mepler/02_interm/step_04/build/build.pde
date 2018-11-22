// step_04 : line graph of new york city education data

String fn = "results_math.csv";
String[] rawData;
ArrayList<Grade> allGrades = new ArrayList<Grade>();

void settings() {
  size(800,300);
}

void setup() {
  processData();
}

void draw() {
  background(#333333);
}

void processData() {
  rawData = loadStrings(fn);
  for(int i=1; i<rawData.length; i+=7) {
    Grade g = new Grade();
    String[] firstRow = split(rawData[i], ";");
    g.level = int(firstRow[0]);
    print(g.level);
    for(int j=0; j<7; j++) {
      String[] thisRow = split(rawData[i+j], ";");
      g.scores[j] = int(thisRow[2]);
    }
    allGrades.add(g);
  }
  for(Grade g : allGrades) {
    println("Level = " + g.level);
  }
}

// --- end --- //
