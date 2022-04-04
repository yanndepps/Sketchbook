int recordFrame = 1;
int recordFrameRate = 5;
float sceneScalar = 0;

void launchRecordVideo() {
  record = !record;
  recordFrame = 1;
}

void playSequence() {
  if (recordFrame < imageFileNames.length-1) {
    recordFrame++;
  } else {
    recordFrame = 0;
    sceneScalar += 0.01;
    exit();
    println("finished recording");
  }
}

void recordVideo() {
  saveFrame("out/" + SEQUENCE_FOLDER_NAME + recordFrame + ".jpg");
}
