/*Sketch informations
 WIFI : pass : !Pca2014 loggin : pcaguest
 While operations 
 */
//Sketch properties
int pWidth = 1280;
int pHeight = 720;
String appName = "Dessine moi une boucle FOR ever";
String version = "Alpha";
String subVersion = "0.0.6";
String frameName;

float xOffset;
float lineInc;
int marginTop, marginBottom, marginLeft, marginRight;
float phi;
float phiOffset;
float phiAmplitude;
int[][] orientationList;
int cols, rows;

void setup()
{
  size(pWidth, pHeight, P3D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  appParameter();

  xOffset = 15;
  lineInc = xOffset/3;
  marginTop = marginBottom = 50;
  marginLeft = marginRight = 50;
  phi = 0.0;
  phiOffset = 0.02;
  phiAmplitude = 25;
  cols = int ((height-(marginBottom+marginTop)) / xOffset);
  rows = int((width-(marginRight+marginLeft)) / xOffset);
  orientationList = new int[cols][rows];
  for (int j = 0; j<cols; j++)
  {
    int orientation = (int) random(4);
    for (int i = 0; i<rows; i++)
    {
      orientationList[j][i] = orientation;
    }
  }
}

void draw()
{
  background(40);
  //translate(width/2, height/2, 200);
  phi += phiOffset;
  float theta = phi;
  for (int j = 0; j<cols; j++)
  {
    float dphi = (TWO_PI/ (height-(marginTop+marginBottom)))*xOffset; 
    int orientation = (int) random(4);
    for (int i = 0; i<rows; i++)
    {
      float x = marginLeft+i*xOffset;
      float y = (marginTop+j*xOffset)+sin(theta)*phiAmplitude;

      float dist = dist(x, y, width/2, height/2);
      float hue = map(dist, 0, height/2, 160, 200);

      noFill();
      stroke(hue, 100, 100);
      /*
      rectMode(CENTER);
       rect(x, y, 25, 25);*/
      if (orientationList[j][i] == 0)
      {
        line(x-lineInc, y, x+lineInc, y);
      } else if (orientationList[j][i] == 1)
      {

        line(x-lineInc, y-lineInc, x+lineInc, y+lineInc);
      } else if (orientationList[j][i] == 2)
      {
        line(x, y-lineInc, x, y+lineInc);
      } else if (orientationList[j][i] == 3)
      {
        
      line(x+lineInc, y-lineInc, x-lineInc, y+lineInc);
      } else
      {
      }

      theta += dphi;
    }
  }



  //drawAxis(100, "RVB");
  showFpsOnFrameTitle();
}

//App Parameters
void appParameter()
{
  frameName = appName+"_"+version+"_"+subVersion;
  frame.setTitle(frameName);
}

void showFpsOnFrameTitle()
{
  frame.setTitle(frameName+"    FPS : "+int(frameRate));
}

void drawAxis(float l, String colorMode)
{
  color xAxis = color(255, 0, 0);
  color yAxis = color(0, 255, 0);
  color zAxis = color(0, 0, 255);

  if (colorMode == "rvb" || colorMode == "RVB")
  {
    xAxis = color(255, 0, 0);
    yAxis = color(0, 255, 0);
    zAxis = color(0, 0, 255);
  } else if (colorMode == "hsb" || colorMode == "HSB")
  {
    xAxis = color(0, 100, 100);
    yAxis = color(115, 100, 100);
    zAxis = color(215, 100, 100);
  }

  pushStyle();
  strokeWeight(1);
  //x-axis
  stroke(xAxis); 
  line(0, 0, 0, l, 0, 0);
  //y-axis
  stroke(yAxis); 
  line(0, 0, 0, 0, l, 0);
  //z-axis
  stroke(zAxis); 
  line(0, 0, 0, 0, 0, l);
  popStyle();
}


void saveImage(String path)
{
  saveFrame(path+frameName+"_Frame_####.tif");
}

void keyPressed()
{
  if(key == 's')
  {
    String p = "C:/Users/Alexandre/Desktop/20141108 - FABWorkshop - boucleFor/Screenshot/";
    saveImage(p);
  }
}


