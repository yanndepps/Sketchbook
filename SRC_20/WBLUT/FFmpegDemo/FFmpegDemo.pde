String pathToFrames;
String pathToOutput;
int frameRate;
int numFrames;
int compression;

void setup() {
  size(1280, 720, P3D);
  smooth(8);
  noCursor(); 
  pathToFrames=sketchPath("frames");
  pathToOutput=sketchPath("output");
  frameRate=30;
  numFrames=360;
  compression=20;
}

void draw() {
  background(15);
  translate(width/2, height/2);
  lights();
  rotateY(radians(frameCount));
  box(200);

  saveFrame(pathToFrames+"/f"+String.format("%04d", frameCount)+".png");
  if (frameCount==numFrames) {
    createMP4();
    noLoop();
  }
}

void createMP4() {
 String timestamp=str(year())+str(month())+str(day())+str(hour())+str(minute())+str(second());
  println("ffmpeg -r "+frameRate+" -f image2 -s "+width+"x"+ height + " -i "+ pathToFrames+ "/f%04d.png -vcodec libx264 -crf " +compression+" -pix_fmt yuv420p "+ pathToOutput +"/output_"+timestamp+".mp4");
  launch("ffmpeg -r "+frameRate+" -f image2 -s "+width+"x"+ height + " -i "+ pathToFrames+ "/f%04d.png -vcodec libx264 -crf " +compression+" -pix_fmt yuv420p "+ pathToOutput +"/output_"+timestamp+".mp4");
}
