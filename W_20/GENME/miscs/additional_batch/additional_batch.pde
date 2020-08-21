// STEP 2

// FIND draw() FUNCTION AND ADD
//   if (doBatch) { batchStep(); }
// NEAR THE END OF THE FUNCTION.
// FOR UNFAMILIAR PPL: THE END OF THE FUNCTION IS NEAR THE CLOSING (MATCHING) CURLY BRACKET

// HERE IS THE EXAMPLE:
void draw() {
  // HERE IS SOMETHING 
  if (doBatch) { batchStep(); } // THIS LINE YOU ADD!!!
} 

// NOW FIND keyPressed() FUNCTION AND ADD
//   if (key == 'b' && !doBatch) {batchProcess();}
// JUST AFTER 'keyPresssed() {' LINE
// LEAVE THE REST UNTOUCHED!

// 
void keyPressed() {
  if (key == 'b' && !doBatch) {batchProcess();}
  // HERE IS THE REST OF MY CODE
}