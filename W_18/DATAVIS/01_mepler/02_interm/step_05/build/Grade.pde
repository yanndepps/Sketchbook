class Grade {

  // variables
  int level;
  int[] years = {2006,2007,2008,2009,2010,2011,2012};
  int[] scores = new int[7];
  int min, max;

  // constructor
  Grade() {

  }  
  // functions
  void setMinMax() {
    min = min(scores);
    max = max(scores);
  }
}
