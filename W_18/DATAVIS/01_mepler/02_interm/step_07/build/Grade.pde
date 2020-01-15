class Grade {

  // variables
  int level;
  int[] years = {2006,2007,2008,2009,2010,2011,2012};
  int[] scores = new int[7];
  int min, max;
  PVector[] pos = new PVector[7];
  PVector button = new PVector();
  int buttonSize = 25;

  // constructor
  Grade() {

  }  
  // functions
  
  void display() {
    stroke(255);
    if(currLevel == level) {
      for(int i=0; i<pos.length; i++) {
        ellipse(pos[i].x, pos[i].y, 10, 10);
        if(i < pos.length-1) {
          line(pos[i].x, pos[i].y, pos[i+1].x, pos[i+1].y);
        }
      }
      fill(200);
      stroke(200);
      ellipse(button.x, button.y, buttonSize, buttonSize);
      fill(40);
      text(level, button.x - 4, button.y + 4);
    } else {
      noFill();
      stroke(0);
      ellipse(button.x, button.y, buttonSize, buttonSize);
      fill(255);
      text(level, button.x - 4, button.y + 4);
    }
  }

  void setMinMax() {
    min = min(scores);
    max = max(scores);
  }

  void setValue() {
    float graphHeight = (height-ySpacer) - ySpacer;
    for(int i=0; i<scores.length; i++) {
      float adjVal = map(scores[i], overallMin, overallMax, 0, graphHeight);
      pos[i] = new PVector();
      pos[i].x = xSpacer * (i+1); 
      pos[i].y = (height-ySpacer) - adjVal;
    }
    // button stuff
    button.y = 25;
    button.x = 250 + ((level - 2) * 40);
  }
}
