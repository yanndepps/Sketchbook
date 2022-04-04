import controlP5.*;
ControlP5 cp5;
import java.util.*;

Slider scalar, skewX, skewY;
Slider2D pos;

color uiBg = #222222;
color c1 = #f1f1f1;
color c2 = #000000;
color c3 = #f1f1f1;
color c4 = #00ff00;

void buildUi() {
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  float margin = 25;

  float uiX = margin;
  float uiY = margin;

  int SLIDER_W = 200;
  int SLIDER_H = 20;

  int SPACING = 30;

  // #####################################
  // Background-Image Skew
  //
  scalar = cp5.addSlider("scalar")
    .setPosition(uiX, uiY)
    .setSize(SLIDER_W, SLIDER_H)
    .setRange(0.2, 2)
    .setValue(0.2)
    .setColorValue(c1)
    .setColorActive(c2)
    .setColorForeground(c3)
    .setColorBackground(c4)
    ;

  uiY += SPACING;

  skewX = cp5.addSlider("skewX")
    .setPosition(uiX, uiY)
    .setSize(SLIDER_W, SLIDER_H)
    .setRange(2, 0)
    .setValue(1)
    .setColorValue(c1)
    .setColorActive(c2)
    .setColorForeground(c3)
    .setColorBackground(c4)
    ;

  uiY += SPACING;

  skewY = cp5.addSlider("skewY")
    .setPosition(uiX, uiY)
    .setSize(SLIDER_W, SLIDER_H)
    .setRange(2, 0)
    .setValue(1)
    .setColorValue(c1)
    .setColorActive(c2)
    .setColorForeground(c3)
    .setColorBackground(c4)
    ;

  // #####################################
  // Background-Image Position
  //

  uiY += SPACING;
  int MAG = 500;

  pos = cp5.addSlider2D("pos")
    .setPosition(width-225, 25)
    .setSize(200, 150)
    .setMinMax(-MAG, -MAG, MAG, MAG)
    .setValue(0, 0)
    .setColorValue(c1)
    .setColorActive(c2)
    .setColorForeground(c3)
    .setColorBackground(c4)
    ;
}

int vectorSelector = 0;

void keyReleased() {
  if (key == '1') {
    vectorSelector = 1;
    VectorSelectionMode = true;
  } else if (key == '2') {
    vectorSelector = 2;
    VectorSelectionMode = true;
  } else if (key == '3') {
    vectorSelector = 3;
    VectorSelectionMode = true;
  } else if (key == '4') {
    vectorSelector = 4;
    VectorSelectionMode = true;
  } else {
    vectorSelector = 0;
    VectorSelectionMode = false;
  }

  if (key == 'r') {
    launchRecordVideo();
  }
  if (key == 'g') {
    showGrid = !showGrid;
  }
}

void mouseReleased() {
  vectorSelector = 0;
  VectorSelectionMode = false;
}
