// STEP 1
// COPY CONTENT OF THIS FILE TO THE END OF THE SCRIPT

void batchCallback(float time) {
  /// every image this functions is called
  /// time ranges from 0 (first image) to 1 (last image)
  /// set global variables or whatever you want
}

void batchStep() {
  File n = batchList[batchIdx];
  String name = n.getAbsolutePath(); 
  if (name.endsWith(fileext)) {
    print(n.getName()+"... ");
    img = loadImage(name);
    img.loadPixels();
    batchCallback((float)batchIdx / batchFiles);
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
