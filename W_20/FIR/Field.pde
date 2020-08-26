ArrayList <Field> fields = new ArrayList <Field>();

class Field {
  float x;
  float y;
  int ID;
  int rowID;
  int colID;
  boolean black = false;
  
  Field(int ID_, int rowID_, int colID_, float x_, float y_) {
    ID = ID_;
    rowID = rowID_;
    colID = colID_;
    x = x_;
    y = y_;
  }
  
  ArrayList <Field> neighbours() {
    ArrayList <Field> list = new ArrayList <Field>();
    for (int i = 0; i < fields.size(); i++) {
      Field otherPoint = fields.get(i);
      if ( otherPoint != this) {
        
        if (isPartOfInterval(otherPoint.rowID, this.rowID-1, this.rowID+1) && isPartOfInterval(otherPoint.colID, this.colID-1, this.colID+1)) {
            list.add(otherPoint);
        }
      }
    }
    return list;
  }
  
  ArrayList <Field> parallelNeighbours() {
    ArrayList <Field> list = new ArrayList <Field>();
    for (int i = 0; i < neighbours().size(); i++) {
      Field otherField = neighbours().get(i);
      
      if(otherField.x == x || otherField.y == y) {
        list.add(otherField);
      }
    }
    return list;
  }
  
  ArrayList <Field> diagonalNeighbours() {
    ArrayList <Field> list = new ArrayList <Field>();
    for (int i = 0; i < neighbours().size(); i++) {
      Field otherField = neighbours().get(i);
      
      if(otherField.x != x && otherField.y != y) {
        list.add(otherField);
      }
    }
    return list;
  }
  
  
  Field randomNeighbour() {
    int rID = int(random(neighbours().size()));
    return neighbours().get(rID);
  }
  
  Field randomParNeighbour() {
    int rID = int(random(parallelNeighbours().size()));
    return parallelNeighbours().get(rID);
  }
  
  int parBlackNeighbourCount = 0;
  int diaBlackNeighbourCount = 0;
  void calcNeighbourCounts() {
    parBlackNeighbourCount = 0;
    diaBlackNeighbourCount = 0;
    for (int i = 0; i < diagonalNeighbours().size(); i++) {
      if(diagonalNeighbours().get(i).black) {
        diaBlackNeighbourCount ++;
      }
    }
    
    for (int i = 0; i < parallelNeighbours().size(); i++) {
      if(parallelNeighbours().get(i).black) {
        parBlackNeighbourCount ++;
      }
    }
  }
  
  
  
  
  // SHOW
  
  void show() {
    
    fill(0);
    noStroke();
    
    showRect();
  }
  
  
  void showRect() {
    rectMode(CENTER);
    rect(x,y,fieldSize, fieldSize);
  }
  
  void showID() {
    fill(255);
    text(ID, x, y);
  }
  
  void reset() {
    black = false;
    parBlackNeighbourCount = 0;
    diaBlackNeighbourCount = 0;
    
  }
  
}

void createFields(int numRows, int numCols) {
  // calc distance between circle centers
  float spacing = margin();
  
  // calc positions, ids
  // create circle objects
  int ID = 0;
  for (int i = 0; i < numCols; i++) {
    int rowID = i;
    float y = rowID * fieldSize + fieldSize/2;
    for (int j = 0; j < numRows; j++) {
      int colID = j;
      float x = colID * fieldSize + fieldSize/2;
      fields.add(new Field(ID, rowID, colID, x, y));
      ID++;
    }
  }
}

void showFields() {
  for (int i= 0; i < fields.size(); i++) {
    fields.get(i).show();
  }
}

float margin() {
  float m = ( width - outerMargin*2 ) / (cols-1);
  return m;
}
