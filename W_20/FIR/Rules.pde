boolean ruleBreak(Path p) {

  for (int f = 0; f < fields.size(); f++) {
    Field field = fields.get(f);
    
    field.calcNeighbourCounts();
    
    // BLACKS
    if (field.black) {
      
      if(field.diaBlackNeighbourCount > 3){
        return true; 
      }
      
      if(field.parBlackNeighbourCount > 3){
        return true; 
      }
      
    // WHITES
    } else {
      
      // 4 parallel
      if(field.parBlackNeighbourCount > 3){
        //println("4 BLACKS PARALLEL");
        return true;
        
      // 3 parallel
      } else if (field.parBlackNeighbourCount == 3) {
        
        // check other white
        for (int i = 0; i < field.parallelNeighbours().size(); i++) {
          if (!field.parallelNeighbours().get(i).black) {
            Field otherWhite = field.parallelNeighbours().get(i);
            if (otherWhite.parBlackNeighbourCount == 3) {
              //println("OTHERWHITE");
              return true;
            }
          } 
        }
        
      }
      
    }

  }
  
  return false;
}
