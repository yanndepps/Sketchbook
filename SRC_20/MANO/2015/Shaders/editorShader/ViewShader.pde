class ViewShader {
  boolean reload, error, loaded;
  File fileShader;
  long timeModi;
  String src;
  PGraphics gra;
  PShader shader;
  ViewShader(String src) {
    this.src = src;
    gra = createGraphics(width, height, P2D);
    this.src = src;
    fileShader = new File(src);
    openShader(fileShader);
  }
  void update() {
    if (reload) {
      openShader(fileShader);
      reload = false;
    }
    if (shader != null) { 
      shader.set("time", millis()/1000.0);
      float x = map(mouseX, 0, width, 0, 1);
      float y = map(mouseY, 0, height, 1, 0);
      shader.set("mouse", x, y); 
      //shader.set("iGlobalTime", frameRate/6.);
      gra.beginDraw();
      gra.background(0);
      gra.shader(shader);
      gra.rect(0, 0, gra.width, gra.height);
      gra.endDraw();

      if (fileShader.lastModified() != timeModi) {
        openShader(fileShader);
      }
    }
  }
  void newShader(String src) {
    this.src = src;
    fileShader = new File(src);
    reload = true;
    //openShader(fileShader);
  }
  void openShader(File file) { 
    if (file != null) {
      fileShader = file;
      timeModi = fileShader.lastModified();
      try { 
        shader = loadShader(file.getAbsolutePath());
        shader.set("resolution", float(width), float(height));
        error = false;
        loaded = true;
      }
      catch (RuntimeException e) {    
        if (error == false) { 
          error = true;
          // String time = nf(str(hour()),2) + ":" + nf(str(minute()),2) + ":" + nf(str(second()),2);
          println("\n");
          // println("At", time, "loadShader() returned the following error: \n");
          println("loadShader() returned the following error: \n");
          e.printStackTrace();
        }
        loaded = false;
      }
    }
  }
}
