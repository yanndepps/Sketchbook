/*
 * A messy set of functions for key interaction and initial data setup
 */

PGraphics g;
String txt = "hotdogs";
int fontIndex;
PFont f;
String s;
String[] fontList;
//////////////////// GRAPHIC FUNCTIONS //////////////////////////

void initPGraphics() {
  g = createGraphics(width, height, JAVA2D);
  //s = PFont.list();
  //printArray(s);
  THETAFINE = 0.5;

  g.beginDraw();
  g.colorMode(HSB, 360, 100, 100);
  fontIndex = 0;
  //s = files[fontIndex].getName();
  f = createFont("IBMPlexSans-Bold", 100);
  //f = createFont(s, FONT_SIZE);
  g.textFont(f, FONT_SIZE);
  g.textSize( FONT_SIZE );
  g.endDraw();
}

void updatePGraphics() {
  g.beginDraw();
  //g.colorMode(HSB,360,100,100);
  g.background(0, 0, 255);
  //f = createFont(s, FONT_SIZE);
  g.textFont(f, FONT_SIZE);
  g.textSize( FONT_SIZE );
  g.textAlign(CENTER, CENTER);
  g.fill(0);
  g.text(txt, g.width/2, g.height/2);
  g.endDraw();

  // DEBUG
  //image(g, 0, 0);
}



//////////////////// INTERACTION : KEYS //////////////////////////
void keyPressed() {

  if(INTERFACES.isMouseOver()==false)
  if (keyCode == BACKSPACE) {
    if (txt.length() > 0) {
      txt = txt.substring(0, txt.length()-1);
    }
  } else if (keyCode == DELETE) {
    txt = "";
  } else if (keyCode != ENTER && key != '-' && keyCode != ALT && keyCode != RIGHT && keyCode != LEFT) {
    fill(255);
    txt = txt + key;
  }

  if (key == '-') {
    saveFrame("StringAgents_###.png");
  }
}

////////////////////// KEYS
void keyReleased() {
  if (keyCode == ENTER) {
    DOT_AGENTS.AgentsCollection.clear();
    DOT_AGENTS.renderGrid(XOFF, YOFF, STEPX, STEPY);
    LINE_AGENTS.AgentsCollection.clear();
    LINE_AGENTS.renderGrid(XOFF, YOFF, STEPX, STEPY);
  }

  // Added angle rotation fine tuning.
  if (keyCode == RIGHT) {
    THETALINE += THETAFINE;
    float temp =  INTERFACES.getController("THETALINE").getValue();
    float newVal = temp + THETAFINE;
    INTERFACES.getController("THETALINE").setValue(newVal);
  }
  if (keyCode == LEFT) {
    THETALINE -= THETAFINE;
    float temp =  INTERFACES.getController("THETALINE").getValue();
    float newVal = temp - THETAFINE;
    INTERFACES.getController("THETALINE").setValue(newVal);
  }
}