import java.io.File;
String [] imageFileNames;
ArrayList images;

void loadSequenceImages(String SEQUENCE_FOLDER_NAME) {
  java.io.File folder = new java.io.File(dataPath("sequences/"+SEQUENCE_FOLDER_NAME));
  imageFileNames = folder.list();
  imageFileNames = sort(imageFileNames);
  println("loading...");
  for (int i = 0; i < imageFileNames.length; i++) {
    String filename = imageFileNames[i];
  }
}
