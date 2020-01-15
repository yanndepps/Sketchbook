// step_05 : line graph of new york city education data

String fn = "results_math.csv";
String[] rawData;
ArrayList<Grade> allGrades = new ArrayList<Grade>();
int overallMin, overallMax;

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
    for(int j=0; j<7; j++) {
      String[] thisRow = split(rawData[i+j], ";");
      g.scores[j] = int(thisRow[2]);
    }
    g.setMinMax();
    allGrades.add(g);
  }
  
  int[] mins = new int[6];
  int[] maxs = new int[6];

  for (int i=0; i<allGrades.size(); i++) {
    Grade g = allGrades.get(i);
    mins[i] = g.min;
    maxs[i] = g.max;
  }
  
  overallMin = min(mins);
  overallMax = max(maxs);

  println(overallMin);
  println(overallMax);

  for(Grade g : allGrades) {
  }
}

// --- end --- //
