class Videowall {

  PGraphics pg;

  float X;
  float Y;
  float Z;
  float ROTX, ROTY, ROTZ;

  color VIDEOWALL_FG = #000000;
  color VIDEOWALL_BG = #F1F1F1;

  int modulo;
  int s;

  Videowall(int _s) {

    modulo = int(random(5, 60));

    pg = createGraphics(600, 400, P3D);

    noStroke();
    
    X = random(-1000, 1000);
    Y = random(-1000, 1000);
    Z = random(-1000, 1000);
    
    X = 0;
    Y = 1700;
    Z = 0;
    
    ROTX = random(-180, 180);
    ROTY = random(-180, 180);
    ROTZ = random(-180, 180);

  }

  void display() {

    float eyeX = pg.width/2.0 + mx * 3;
    float eyeY = pg.height/2.0;
    float eyeZ =(pg.height/2.0) / tan(PI*30.0 / 180.0);
    float centerX = pg.width/2.0;
    float centerY = pg.height/2.0;
    float centerZ = 0;
    float upX = 0;
    float upY = 1;
    float upZ = 0;

    pg.beginDraw();
    pg.background(VIDEOWALL_FG);
    pg.camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
    pg.fill(VIDEOWALL_BG);
    pg.directionalLight(255, 255, 255, -1, 0, 0);
    pg.noStroke();
    pg.translate(pg.width/2, pg.height/2);
    pg.sphere(160);
    pg.endDraw();
  }
}
