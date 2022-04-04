// #####################################
// Settings for the project

int WIDTH = 600;
int HEIGHT = 450;
String SCENE_IMAGE_FILENAME = "1.jpg";
String SEQUENCE_FOLDER_NAME = "pcd22";

// Ken Burns Zoom
float SCALE_FROM = 1;
float SCALE_TO = 1.13;

// #####################################
// Application State

PImage sceneImage;
PGraphics pg;
PGraphics grid;
boolean record = false;
boolean showGrid = true;
boolean showUi = true;
boolean VectorSelectionMode = false;

// Positions of the 4 Vectors
float initialMagX = 300;
float initialMagY = 200;
float v1x = -initialMagX;
float v1y = -initialMagY;
float v2x = initialMagX;
float v2y = -initialMagY;
float v3x = initialMagX;
float v3y = initialMagY;
float v4x = -initialMagX;
float v4y = initialMagY;

int DESIGN = 0;
int SELECTIMAGE = 1;

int view = DESIGN;

void setup() {
  sceneImage = loadImage("scenes/" + SCENE_IMAGE_FILENAME);
  sceneImage.filter(GRAY);
  pg = createGraphics(WIDTH, HEIGHT, P3D);
  buildUi();
  frameRate(30);
  loadSequenceImages(SEQUENCE_FOLDER_NAME);
}

void settings() {
  size(WIDTH, HEIGHT, P3D);
}

void draw() {
  background(0);

  if (record) {
    playSequence();
  }


  float offsetX = pos.getArrayValue()[0];
  float offsetY = pos.getArrayValue()[1];
  float W = skewX.getValue();
  float H = skewY.getValue();
  float scalarValue = scalar.getValue();

  pg.beginDraw();
  pg.clear();
  pg.imageMode(CENTER);

  pg.push();
  pg.translate(width/2, height/2);

  // Ken Burns Zoom
  if (record) {
    float kenBurnsScalar = map(recordFrame, 1, imageFileNames.length, SCALE_FROM, SCALE_TO);
    pg.scale(kenBurnsScalar);
  }
  // /END Ken Burns Zoom

  pg.push();

  pg.translate(offsetX, offsetY);
  pg.scale(scalarValue);
  pg.scale(W, H);

  if (record) {
    pg.noTint();
  } else {
    pg.tint(255, 170);
  }
  pg.image(sceneImage, 0, 0);
  pg.pop();

  if (vectorSelector == 1) {
    v1x = -width/2+mouseX;
    v1y = -height/2+mouseY;
  }

  if (vectorSelector == 2) {
    v2x = -width/2+mouseX;
    v2y = -height/2+mouseY;
  }

  if (vectorSelector == 3) {
    v3x = -width/2+mouseX;
    v3y = -height/2+mouseY;
  }

  if (vectorSelector == 4) {
    v4x = -width/2+mouseX;
    v4y = -height/2+mouseY;
  }

  pg.imageMode(CENTER);
  pg.push();
  pg.translate(0, 0);
  pg.textureMode(NORMAL);
  pg.textureWrap(REPEAT);
  pg.noFill();

  if (!record) {
    pg.strokeWeight(3);
    pg.stroke(#00ff00);
  } else {
    pg.noStroke();
  }

  pg.beginShape();
  if (record) {
    String textureImageFileName = "sequences/pcd22/" + imageFileNames[recordFrame];
    PImage textureImage = loadImage(textureImageFileName);
    pg.texture(textureImage);
  }
  pg.vertex(v1x, v1y, 0, 0);
  pg.vertex(v2x, v2y, 1, 0);
  pg.vertex(v3x, v3y, 1, 1);
  pg.vertex(v4x, v4y, 0, 1);
  pg.endShape(CLOSE);

  pg.pop();
  pg.pop();
  pg.endDraw();

  image(pg, 0, 0);

  if (!record) {
    image(displayGrid(), 0, 0);
    // Show UI only when vectorSelection is Off!
    if (!VectorSelectionMode) {
      cp5.draw();
    }
  }

  recordVideo();
}
