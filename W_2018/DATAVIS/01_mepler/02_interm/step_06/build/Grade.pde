class Grade {

  // variables
  int level;
  int[] years = {2006,2007,2008,2009,2010,2011,2012};
  int[] scores = new int[7];
  int min, max;
  PVector[] pos = new PVector[7];

  // constructor
  Grade() {

  }  
  // functions
  
  void display() {
    if(currLevel == level) {
      text(level, 50, 50);

      for(int i=0; i<pos.length; i++) {
        ellipse(pos[i].x, pos[i].y, 10, 10);
      }
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
      println(pos[i].x);
      println(pos[i].y);
    }
  }
}
