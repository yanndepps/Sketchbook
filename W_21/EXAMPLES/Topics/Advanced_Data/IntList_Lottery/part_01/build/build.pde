/**
 * IntList Lottery example
 * by Daniel Shiffman.  
 * 
 * This example demonstrates an IntList can be used to store a list of numbers.
 * While an array of integers serves a similar purpose it is of fixed size.  The
 * An IntList can easily have values added or deleted and it can also be 
 * shuffled and sorted.  For lists of floats or Strings, you can use FloatList
 * and StringList.  For lists of objects, use ArrayList.
 *
 * In this example, three lists of integers are created.  One is a pool of numbers
 * that is shuffled and picked randomly from.  One is the list of "picked" numbers.
 * And one is a lottery "ticket" which includes 5 numbers that are trying to be matched.
 *
 * Featured functions :
 * IntList append()
 * IntList size()
 * IntList get()
 * IntList remove()
 * IntList clear()
 *
 * Also, this is supposed to help me with my octahedral die replacement ...
 */
 
// Three lists of integers
IntList lottery;
IntList results;
IntList ticket;

int octaDie = 8;

void setup() {
  size(260, 260);
  frameRate(15);

  // create empty lists
  lottery = new IntList();
  results = new IntList();
  ticket = new IntList();

  // add 20 integers in order to the lottery list
  for (int i = 1; i <= octaDie; i++) {
    lottery.append(i);
  }

  // pick five numbers from the lottery list to go into the Ticket list
  for (int i = 1; i <= 5; i++) {
    int index = int(random(lottery.size()));
    ticket.append(lottery.get(index));
  }
}

void draw() {
  background(33);

  // The shuffle() method randomly shuflles the order of the values 
  // in the list
  lottery.shuffle();

  // Call a method that will display the integers in the list at an x,y location
  showList(lottery, 16, 48);
  showList(results, 16, 100);
  showList(ticket, 16, 140);

  // This loop checks if the picked numbers ( results ) match
  // the ticket numbers
  for (int i = 0; i < results.size(); i++) {
    // are the integers equals ?
    if (results.get(i) == ticket.get(i)) {
      // if so -> green color
      fill(0, 255, 0, 100);
    } else {
      // if not -> red color
      fill(255, 0, 0, 100);
    }
    ellipse(16+i*32, 140, 24, 24);
  }

  // One every 30 frames we pick a new lottery number to go in results
  if (frameCount % 30 == 0) {
    if (results.size() < 5) {
      // Get the first value in the lottery list and remove it
      int val = lottery.remove(0);
      // Put it in the results
      results.append(val);
      results.sort();
      // Console log the sorted results
      println(results);
    } else {
      // Ok we picked five numbers, let's reset
      for (int i = 0; i < results.size(); i++) {
        // Put the picked results back into the lottery
        lottery.append(results.get(i));
      }
      // Clear the results and start over
      results.clear();
    }
  }
}

// Draw a list of numbers starting at an x,y location
void showList(IntList list, float x, float y) {
  for (int i = 0; i < list.size(); i++) {
    // Use get() to pull a value from the list at the specified index
    int val = list.get(i);
    stroke(255);
    noFill();
    ellipse(x+i*32, y, 24, 24);
    textAlign(CENTER);
    fill(255);
    text(val, x+i*32, y+6);
  }
}
