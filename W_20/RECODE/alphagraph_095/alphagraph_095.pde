/*
 * PLEASE READ INFO TAB FOR FURTHER INFO
 * NOTES : Version _095 used ESAC CAMBRAI ARC 2018
 * WEB :   https://parametrictype.bitbucket.io
 */

///////////////// GLOBALS ///////////////////////////////
import controlP5.*;
import processing.pdf.*;
boolean SAVE_PDF = false;

ControlP5 INTERFACES;
Grid LINE_AGENTS;
Grid DOT_AGENTS;

///////////////// SETUP ///////////////////////////////
void setup() {
  size(1280, 720, JAVA2D);
  surface.setResizable(true);
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);
  smooth();
  controlInit(); // initialise GUI (Contains variable instances too !)
  initPGraphics(); // initialise PGraphics ( FONTS )
  
  // create a grid & render with x, y & step values
  LINE_AGENTS = new Grid();
  LINE_AGENTS.renderGrid(XOFF, YOFF, STEPX, STEPY);
  DOT_AGENTS = new Grid();
  DOT_AGENTS.renderGrid(XOFF, YOFF, STEPXDOT, STEPYDOT);

}

//////////////////// DRAW ///////////////////////////////
void draw() {
  
  if (SAVE_PDF) beginRecord(PDF, "exportPDF_###.pdf");
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 0);
  updatePGraphics(); // update PGraphics ( TEXT )

  if (isInvert) {
    if (SHOWCIRCLES) {
      DOT_AGENTS.drawCircleAgents();
    }

    if (SHOWLINES) {
      LINE_AGENTS.drawLineAgents();
    }
  } else {

    if (SHOWLINES) {
      LINE_AGENTS.drawLineAgents();
    }
    if (SHOWCIRCLES) {
      DOT_AGENTS.drawCircleAgents();

    }
  }

  if (SAVE_PDF) {
    endRecord();
    SAVE_PDF = false;
  }

  updateGrid(XOFF, YOFF, STEPX, STEPY, STEPXDOT, STEPYDOT);
  
}

///////////////////////////////////// FIN