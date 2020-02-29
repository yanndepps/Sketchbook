/*
 * shows how to interpolate colors in different styles/color modes
 *
 * MOUSE
 * left click        : new random color set
 * position x        : interpolation resolution
 * position y        : row count
 *
 * KEYS
 * 1-2               : switch interpolation style 
 * s                 : save png
 * p                 : save pdf
 * c                 : save color palette
 */ 

import generativedesign.*;
import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

int tileCountX = 2;
int tileCountY = 10;

color[] colorsLeft = new color[tileCountY];
color[] colorsRight = new color[tileCountY];
color[] colors;

boolean interpolateShortest = true;

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  shakeColors();
}

void draw() {
  if (savePDF) {
    beginRecord(PDF, timestamp()+".pdf");
    noStroke();
    colorMode(HSB, 360, 100, 100, 100);
  }

  tileCountX = (int) map(mouseX, 0, width, 2, 100);
  tileCountY = (int) map(mouseY, 0, height, 2, 10);
  float tileWidth = width / (float)tileCountX;
  float tileHeight = height / (float)tileCountY;
  color interCol;

  //ase export
  colors = new color[tileCountX*tileCountY];
  int i = 0;

  for (int gridY = 0; gridY < tileCountY; gridY++) {
    color col1 = colorsLeft[gridY];
    color col2 = colorsRight[gridY];

    for (int gridX = 0; gridX < tileCountX; gridX++) {
      float amount = map(gridX, 0, tileCountX-1, 0, 1);
      if (interpolateShortest) {
        // switch to rgb
        colorMode(RGB, 255, 255, 255, 255);
        interCol = lerpColor(col1, col2, amount);
        // switch back
        colorMode(HSB, 360, 100, 100, 100);
      } else {
        interCol = lerpColor(col1, col2, amount);
      }
      fill(interCol);
      float posX = tileWidth*gridX;
      float posY = tileHeight*gridY;
      rect(posX, posY, tileWidth, tileHeight);
      // ase export 
      colors[i] = interCol;
      i++;
    }
  }

  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

void shakeColors() {
  for (int i = 0; i < tileCountY; i++) {
    colorsLeft[i] = color(random(0,60), random(0, 100), 100);
    colorsRight[i] = color(random(160,190), 100, random(0,100));
  }
}

void mouseReleased() {
  shakeColors();
}

void keyReleased() {
  if (key == 'c' || key == 'C') GenerativeDesign.saveASE(this, colors, timestamp()+".ase");
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;
  if (key == '1') interpolateShortest = true;
  if (key == '2') interpolateShortest = false;
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format( "%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now );
}
