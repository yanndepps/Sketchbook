// Original: http://www.openprocessing.org/sketch/145401
// adaptation to images, Tomasz Sulej, generateme.blog@gmail.com
// Licence CC-BY-SA 3.0

// put image filename here:
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

int ticks=30; // number of iterations
int n=2000; // number of points

// choose channel  
int channel = RED; 

// run, after 30 iterations result will be saved automatically
// or press SPACE

int max_display_size = 800; // viewing window size (regardless image size)

/////////////////////////////////////

// channels to work with
final static int RED = 0;
final static int GREEN = 1;
final static int BLUE = 2;
final static int HUE = 3;
final static int SATURATION = 4;
final static int BRIGHTNESS = 5;
final static int NRED = 6;
final static int NGREEN = 7;
final static int NBLUE = 8;
final static int NHUE = 9;
final static int NSATURATION = 10;
final static int NBRIGHTNESS = 11;

float [] cx=new float[n];
float [] cy=new float[n];

PImage img;
int len;

// working buffer
PGraphics buffer; 

String sessionid; 

void setup() {
  sessionid = hex((int)random(0xffff), 4);
  img = loadImage(foldername+filename+fileext);

  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.noFill();
  buffer.smooth(8);
  buffer.strokeWeight(0.3);
  buffer.background(0);
  buffer.endDraw();

  // calculate window size
  float ratio = (float)img.width/(float)img.height;
  int neww, newh;
  if (ratio < 1.0) {
    neww = (int)(max_display_size * ratio);
    newh = max_display_size;
  } else {
    neww = max_display_size;
    newh = (int)(max_display_size / ratio);
  }

  size(neww, newh);

  len = (img.width<img.height?img.width:img.height)/6;

  background(0);
  for (int i=0; i<n; i++) {
    cx[i]=random(img.width);
    cy[i]=random(img.height);
  }

  //processImage();
}

int tick = 0;

void draw() {
  // fill for iterative processing
  if (doBatch) {
    batchStep();
  }
} 

void processImage() {  
  buffer.beginDraw();
  buffer.background(0);
  for (int tick=0; tick<ticks; tick++) {

    println("iteration: " + tick);
    for (int l=0; l<len; l++) {
      for (int i=1; i<n; i++) {
        color c = img.get((int)cx[i], (int)cy[i]);
        buffer.stroke(c);
        buffer.point(cx[i], cy[i]);
        // you can choose channels: red(c), blue(c), green(c), hue(c), saturation(c) or brightness(c)
        cy[i]+=sin(map(getChannel(c), 0, 255, 0, TWO_PI));
        cx[i]+=cos(map(getChannel(c), 0, 255, 0, TWO_PI));
      }
    }
    for (int i=0; i<n; i++) {
      cx[i]=random(img.width);
      cy[i]=random(img.height);
    }
  }
  buffer.endDraw();

  image(buffer, 0, 0, width, height);
}

float getChannel(color c) {
  int ch = channel>5?channel-6:channel;
  float cc;

  switch(ch) {
  case RED: 
    cc = red(c); 
    break;
  case GREEN: 
    cc = green(c); 
    break;
  case BLUE: 
    cc = blue(c); 
    break;
  case HUE: 
    cc = hue(c); 
    break;
  case SATURATION: 
    cc = saturation(c); 
    break;
  default: 
    cc= brightness(c); 
    break;
  }

  return channel>5?255-cc:cc;
}

void keyPressed() {
  if (key == 'b' && !doBatch) {
    batchProcess();
  }
  // buffer.save(foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext);
  // println("image saved");
}

void batchStep() {
  File n = batchList[batchIdx];
  String name = n.getAbsolutePath(); 
  if (name.endsWith(fileext)) {
    print(n.getName()+"... ");
    img = loadImage(name);
    //    batchCallback((float)batchIdx / batchFiles);
    processImage();
    buffer.save(foldername+batchUID+"/"+n.getName());
    println("saved");
  }
  batchIdx++;
  if (batchIdx >= batchList.length) {
    doBatch = false;
    println("results saved in "+ foldername+batchUID + " folder");
  }
}

File[] batchList;
int batchIdx = 0;
String batchUID;
boolean doBatch = false;
float batchFiles = 0;
void batchProcess() {
  batchUID = sessionid + hex((int)random(0xffff), 4);
  File dir = new File(sketchPath+'/'+foldername);
  batchList = dir.listFiles();
  batchIdx = 0;
  batchFiles = 0;
  for (File n : batchList) {
    if (n.getName().endsWith(fileext)) batchFiles=batchFiles+1.0;
  }
  println("Processing "+int(batchFiles)+" images from folder: " + foldername);
  doBatch = true;
}