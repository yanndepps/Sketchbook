import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

//To get this running: download the ldraw parts archives and unzip them somewhere keeping the dir structure intact

//http://www.ldraw.org/library/unofficial/ldrawunf.zip
//http://www.ldraw.org/library/updates/complete.zip

//Models can be found at http://omr.ldraw.org/ and other places, search term "ldraw lego model"



//location of ldraw directory from above archives, in my case d:\OneDrive\resources\ldraw\
String path="D:/OneDrive/resources/ldraw/";

//dirs where to look for parts, subparts and models
String[] dataDir;

//folder where to look for models and to unpack multi part files
String modelPath;
String mainFile;
String[] data;
PShape model, tris, quads, edges;
List<ConditionalLine> condLines;
float zoom;
float dx, dy, dz;
Map<String, String[]> parts;
Map<Integer, Integer> colors;
Map<Integer, Integer> edgeColors;
Map<Integer, Integer> alpha;

void setup() {
  fullScreen(P3D);
  smooth(8);
  modelPath=sketchPath("models")+"/";
  dataDir=new String[]{
    path+"parts/s/", 
    path+"parts/", 
    //path+"p/48/",
    path+"p/", 
    path+"models/", 
    modelPath};

  setColors(150);
  parts=new HashMap<String, String[]>();
  load("1462-1.mpd");//should be able to load .dat, .ldr and .mpd (http://omr.ldraw.org/list/). L3B and other derived file formats might work too.
  zoom=1.0;
}

void draw() {
  background(15);
  hint(ENABLE_DEPTH_SORT);
  translate(width/2+dx, height/2+dy,dz);
  lights();
  pointLight(255, 255, 255, 100, 40, 20);
  pointLight(255, 255, 255, -100, 40, -20);
  rotateX(mouseY*TWO_PI/height);
  rotateY(-mouseX*TWO_PI/width);
  scale(zoom);
  strokeWeight(1.0/zoom);
  shape(edges);
  shape(model);
  for (ConditionalLine condLine : condLines) {
    condLine.draw();
  }
}

void keyPressed() {
  if (key=='+') {
    zoom+=0.05;
  } else if (key=='-') {
    zoom-=0.05;
  }else if (key=='*') {
    dz+=10;
  }else if (key=='/') {
    dz-=10;
  }else
  if (key==CODED) {
    if (keyCode==UP) {
      dy-=10;
    } else if (keyCode==DOWN) {
      dy+=10;
    } else  if (keyCode==LEFT) {
      dx-=10;
    } else if (keyCode==RIGHT) {
      dx+=10;
    }
  }
}
