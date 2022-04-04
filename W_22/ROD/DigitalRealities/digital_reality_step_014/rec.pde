final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

void rec(int rate, int dur) {
  if (frameCount == 1) {
    videoExport = new VideoExport(this, "../"+sketchname + timestamp() +".mp4");
    videoExport.setFrameRate(rate);  
    videoExport.startMovie();
  }

  videoExport.saveFrame();
  
  if (frameCount == dur) {
   exit(); 
  }
  println(frameCount);

}

String timestamp() {
  int y = year();   // 2003, 2004, 2005, etc.
  int m = month();  // Values from 1 - 12
  int d = day();    // Values from 1 - 31
  int h = hour();   // 2003, 2004, 2005, etc.
  int mi = minute();   // 2003, 2004, 2005, etc.
  int sec = second();
  int mill = millis();

  String val = 
    "_" +
    String.valueOf(y) +  
    String.valueOf(m) +
    String.valueOf(d) + "_" + 
    String.valueOf(h) + "_" + 
    String.valueOf(mi) + "_" +  
    String.valueOf(sec) + "_" + 
    String.valueOf(mill);

  return val;
}
