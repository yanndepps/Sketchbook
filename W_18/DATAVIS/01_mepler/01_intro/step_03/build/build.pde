// step_03

String fn = "data.csv";
String[] rawData;
int[] years = new int[7];
int[] scores = new int[7];
float xSpacer;
PVector[] positions = new PVector[7];
int overallMin, overallMax;

int margin, graphHeight;

void settings(){
  size(800,300);
}

void setup(){
  processData();
}

void draw(){
  background(#104B51);
  drawGUI();
  fill(#FCA11D);
  noStroke();
  for(int i = 0; i < positions.length; i++) {
    ellipse(positions[i].x, positions[i].y, 15, 15);
  }
}

void processData() {
  rawData = loadStrings(fn);
  for(int i = 2; i < rawData.length; i++) {
    String[] thisRow = split(rawData[i], ";");
    years[i-2] = int(thisRow[1]);
    scores[i-2] = int(thisRow[2]);
  }

  overallMin = min(scores);
  overallMax = max(scores);

  margin = 50;
  graphHeight = (height-margin) - margin;
  xSpacer = (width - margin - margin) / (years.length - 1);

  for(int i = 0; i < scores.length; i++) {
    float adjScore = map(scores[i], overallMin, overallMax, 0, graphHeight);
    float ypos = height - margin - adjScore;
    float xpos = margin + (xSpacer * i);
    positions[i] = new PVector(xpos, ypos);
  }
}

void drawGUI() {
  for(int i = 0; i < positions.length; i++) {
    stroke(200, 100);    
    line(positions[i].x, margin, positions[i].x, height-margin);
    text(years[i], positions[i].x - 15, height - margin + 20);
    if(i > 0) {
      stroke(200, 130);
      line(positions[i].x, positions[i].y, positions[i-1].x, positions[i-1].y);
    }
  }
  text(overallMax, 5, margin);
  text(overallMin, 5, height-margin);
}
