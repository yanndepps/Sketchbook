/*
 * The Grid class generates a grid of Agents
 * It also controls the display of these Agents
 * as points &/or lines.
 *
 */
////////////////////////////////

class Grid {
  ArrayList <Agent> AgentsCollection;

  Grid() {
    AgentsCollection = new ArrayList<Agent>();
  }


  //////////////////////////////////////////////// MÉTHODES
  void renderGrid(float xOff, float yOff, float interX, float interY) {
    AgentsCollection.clear(); // IMPORTANT ! 

    for (float y=10; y<height-10; y+=interY) {
      for (float x=10; x<width-10; x+=interX) {

        // Initialise each object with the constructor
        Agent myAgent = new Agent(x+xOff, y+yOff);

        // Add each object to the ArrayList
        AgentsCollection.add(myAgent);
      }
    }
  }

  // DRAW AGENTS ON GRID AS DOTS
  void drawCircleAgents() {    
    for (Agent ag : AgentsCollection) {

      if (MOUSE_ANIME) {
        if (mousePressed) {
          float nAMM_Motion = map(mouseY, 0, height, 1, 500);
          ag.motion( nAMM_Motion );
        }
      } 

      ag.renderAgents();
      ag.displayDots();
    }
  }

  // DRAW AGENTS ON GRID AS LINES
  void drawLineAgents() {
    for (Agent ag : AgentsCollection) {
      ag.dia = DIA;
      ag.len = LEN;
      ag.strokeW = STROKEW;
      ag.angle = THETALINE; 

      if (MOUSE_ANIME) {
        if (mousePressed) {
          float nAMM_Motion = map(mouseY, 0, height, 1, 500);
          ag.motion( nAMM_Motion );
        }
      } 
      ag.renderAgents();
      ag.displayLines();
    }
  }
}
///////////////////////////////////////////////////////// FIN