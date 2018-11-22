// step_06 : line graph of new york city education data

PFont myFont;
String fn = "results_math.csv";
String[] rawData;
ArrayList<Grade> allGrades = new ArrayList<Grade>();
int overallMin, overallMax;
float xSpacer, ySpacer;
int currLevel = 6;

void settings() {
  size(800,500);
  }

void setup() {
  processData();
  myFont = createFont("Hack", 12);
  textFont(myFont);
  // list fonts
  /* String[] fontList = PFont.list(); */
  /* printArray(fontList); */
}

void draw() {
  background(40);
  drawGUI();
  for(Grade g : allGrades) {
    g.display();
  }
}

void mouseReleased() {
  if(currLevel == 8) {
    currLevel = 3;
  } else {
    currLevel++;
  }
}

void drawGUI() {
  fill(100);
  stroke(200);
  int[] years = {2006, 2007, 2008, 2009, 2010, 2011, 2012};
  int[] grades = {3, 4, 5, 6, 7, 8};

  // x axis
  for(int x=0; x<years.length; x++) {
    float xPos = xSpacer + (xSpacer * x);    
    line(xPos, height-ySpacer, xPos, ySpacer);
    text(years[x], xPos-15, height-(ySpacer-20));
  }
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

  xSpacer = width / (7+1);
  ySpacer = 100;

  int[] mins = new int[6];
  int[] maxs = new int[6];

  for (int i=0; i<allGrades.size(); i++) {
    Grade g = allGrades.get(i);
    mins[i] = g.min;
    maxs[i] = g.max;
  }

  overallMin = min(mins);
  overallMax = max(maxs);

  for(Grade g : allGrades) {
    g.setValue();
  }
}

// --- end --- //
