ArrayList <Path> paths = new ArrayList <Path>();

class Path {
  ArrayList <Field> pathFields = new ArrayList <Field>();
  Field startingField;
  
  Path() {
    resetFields();
    create();
  }
  
  String name() {
    int len = pathFields.size();
    String pointIds = "";
    String sortedPointIds = "";
    
    ArrayList <Integer> pointIdList = new ArrayList <Integer>();
    
    // add points to array
    for (int i = 0; i < pathFields.size(); i++) {
      pointIdList.add(pathFields.get(i).ID);
    }
    
    // drawing order point ids
    for (int i = 0; i < pointIdList.size(); i++) {
      pointIds = pointIds + "-" + pointIdList.get(i);
    }
    
    // sort point id list
    java.util.Collections.sort(pointIdList);  
    for (int i = 0; i < pointIdList.size(); i++) {
      sortedPointIds = sortedPointIds + "-" + pointIdList.get(i);
    }
    
    //String name = "s_" + len + "_p_" + sortedPointIds + "_o_" + pointIds;
    String name = "p" + pointIds;
    return name;
  }
  
  void create(){
    startingField = fields.get(int(random(0, fields.size() )));
    //println(startingPoint.rowID, startingPoint.colID);
    pathFields.add(startingField);
    startingField.black = true;
    addField(startingField);
  }
  
  void resetFields() {
    for (int i = 0; i < fields.size(); i++) {
      fields.get(i).reset();
    }
  }
  
  int iteration = 0;
  void addField(Field lastField) {
    Field newField = lastField.randomParNeighbour();
    
    if (iteration < 100) {
      iteration++;
      
      newField.calcNeighbourCounts();

      if(newField.parBlackNeighbourCount < 2) {
      newField.black = true;
        
        // if not in list - add
        if(!pathFields.contains(newField)) {
          pathFields.add(newField);
        }
        
      //recursion
        int rnd = int(random(0,3));
        if(rnd > 1) {
          addField(lastField);
        }
        addField(newField);
        
      } else {
        addField(lastField);
      }

    } 
  }
  
  void show() {
    for (int i = 0; i < pathFields.size(); i++) {
      pathFields.get(i).show();
    }
  }  
}
