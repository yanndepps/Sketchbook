/*
 * generate specific color palettes
 *
 * MOUSE
 * position x/y        : row and column count
 *
 * KEYS
 * 0-9                 : creates specific color palettes
 * s                   : save png
 * p                   : save pdf
 * c                   : save color palette
 */

import generativedesign.*;
import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

int tileCountX = 50;
int tileCountY = 10;

// arrays for color components values
int[] hueValues = new int[tileCountX];
int[] saturationValues = new int[tileCountX];
int[] brightnessValues = new int[tileCountX];

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  // init with random values
  for (int i = 0; i < tileCountX; i++) {
    hueValues[i] = (int) random(0, 360);
    saturationValues[i] = (int) random(0, 100);
    brightnessValues[i] = (int) random(0, 100);
  }
}

void draw() {
  if (savePDF) {
    beginRecord(PDF, timestamp()+".pdf");
    noStroke();
    colorMode(HSB, 360, 100, 100, 100);
  }
  background(0, 0, 100);

  // count every tile
  int counter = 0;

  // map mouse to grid resolution
  int currentTileCountX = (int) map(mouseX, 0, width, 1, tileCountX);
  int currentTileCountY = (int) map(mouseY, 0, height, 1, tileCountY);
  float tileWidth = width / (float) currentTileCountX;
  float tileHeight = height / (float) currentTileCountY;

  for (int gridY = 0; gridY < tileCountY; gridY++) {
    for (int gridX = 0; gridX < tileCountX; gridX++) {
      float posX = tileWidth*gridX;
      float posY = tileHeight*gridY;
      int index = counter % currentTileCountX;

      // get component color values
      fill(hueValues[index], saturationValues[index], brightnessValues[index]);
      rect(posX, posY, tileWidth, tileHeight);
      counter++;
    }
  }

  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;
  if (key == 'c' || key == 'C') {
    // save as an ASE file
    // create palette
    color[] colors = new color[hueValues.length];
    for (int i = 0; i < hueValues.length; i++) {
      colors[i] = color(hueValues[i], saturationValues[i], brightnessValues[i]);
    }
    GenerativeDesign.saveASE(this, colors, "example.ase");
    println("file example.ase saved");
  }

  if (key == '1') {
    for (int i = 0; i < tileCountX; i++) {
      hueValues[i] = (int) random(0, 360);
      saturationValues[i] = (int) random(0, 100);
      brightnessValues[i] = (int) random(0, 100);
    }
  }

  if (key == '2') {
    for (int i = 0; i < tileCountX; i++) {
      hueValues[i] = (int) random(0, 360);
      saturationValues[i] = (int) random(0, 100);
      brightnessValues[i] = 100; 
    }
  }

  if (key == '3') {
    for (int i = 0; i < tileCountX; i++) {
      hueValues[i] = (int) random(0, 360);
      saturationValues[i] = 100;
      brightnessValues[i] = (int) random(0, 100); 
    }
  }

  if (key == '4') {
    for (int i = 0; i < tileCountX; i++) {
      hueValues[i] = 0; 
      saturationValues[i] = 0;
      brightnessValues[i] = (int) random(0, 100); 
    }
  }

  if (key == '5') {
    for (int i = 0; i < tileCountX; i++) {
      hueValues[i] = 195; 
      saturationValues[i] = 100;
      brightnessValues[i] = (int) random(0, 100); 
    }
  }

  if (key == '6') {
    for (int i = 0; i < tileCountX; i++) {
      hueValues[i] = 195; 
      saturationValues[i] = (int) random(0, 100);
      brightnessValues[i] = 100;
    }
  }

  if (key == '7') {
    for (int i = 0; i < tileCountX; i++) {
      hueValues[i] = (int) random(0, 180);
      saturationValues[i] = (int) random(80, 100);
      brightnessValues[i] = (int) random(50, 90);
    }
  }

  if (key == '8') {
    for (int i = 0; i < tileCountX; i++) {
      hueValues[i] = (int) random(180, 360);
      saturationValues[i] = (int) random(80, 100);
      brightnessValues[i] = (int) random(50, 90);
    }
  }

  if (key == '9') {
    for (int i = 0; i < tileCountX; i++) {
      if (i%2 == 0) {
      hueValues[i] = (int) random(0,360); 
      saturationValues[i] = 100; 
      brightnessValues[i] = (int) random(0, 100);
      } else {
      hueValues[i] = 195; 
      saturationValues[i] = (int) random(0, 100);
      brightnessValues[i] = 100; 
      }
    }
  }

  if (key == '0') {
    for (int i = 0; i < tileCountX; i++) {
      if (i%2 == 0) {
      hueValues[i] = 192; 
      saturationValues[i] = (int) random(0, 100);
      brightnessValues[i] = (int) random(10, 100);
      } else {
      hueValues[i] = 273; 
      saturationValues[i] = (int) random(0, 100);
      brightnessValues[i] = (int) random(10, 90);
      }
    }
  }

}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
