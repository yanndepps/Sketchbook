/*
 * The Agent class draws the graphical elements - point & line
 * as well as controls various motions/animations
 *
 */

////////////////////////////////////// CLASS 
class Agent {
  float x, y;
  float dia, len, strokeW, angle;
  color c;
  
  // SUPER PERLIN
  int noiseRes = 5;
  float noiseVal;
  float noiseScale = 0.001;
  float noiseCount = 0.0;
  float noiseSpeed = 0.002;
  float xv, yv;

  float speed = 900;
  float xCount, xSpeed;
  float yCount, ySpeed;
  float theta;


  ///////////////////////////////////// CONSTRUCTOR 01
  Agent(float x, float y) {
    this.x = x;
    this.y = y;
    dia = DIA;
    len = LEN;
    strokeW = STROKEW;
    angle = 0;
  }

  //////////////////////////// METHODS

  // General method that brings all together
  void renderAgents() {

    if (NOISE_01) {
      noise_01(KEN_P_AMM, KEN_P_FACT*KEN_F_AMM);
    }

    if (NOISE_02) {
      noise_02(KEN_P_AMM, KEN_P_FACT*KEN_F_AMM); // original
    }

    if (ANIME_LINES) {
      noise_03(KEN_P_AMM, KEN_P_FACT*KEN_F_AMM);
    }


    if (ANIMATE) {
      float nAMM = map(mouseX, 0, width, 1, 73);
      float nF = map(mouseY, 0, height, 0.0001, 0.009);
      float nFAuto = cos(frameCount*(nF*0.1)) * 0.05;
      noise_01(nAMM, nFAuto);
    }
  }

  //////////////////////////////////////////////////////////// MOTION METHODS

  // 2D noise animation of circle diameters (WITH MOTION)
  void noise_01(float nAmm, float nFac) {
    float noiseAlgo1 = noise((x+frameCount) * nFac, (y+frameCount) * nFac) * nAmm;
    dia = noiseAlgo1 + DIA;
  }

  // 2D noise animation of circle diameters (WITHOUT MOTION)
  void noise_02(float nAmm, float nFac) {
    float noiseAlgo2 = noise((y+nFac) * nFac) * nAmm;
    dia = noiseAlgo2 + DIA;
    //strokeW = noiseAlgo2 + STROKE_W/5; // add stroke ?
  }

  // 2D noise animation of line stroke weight (WITH MOTION)
  void noise_03(float nAmm, float nFac) {
    float noiseAlgo3 = noise((x+nFac) * nFac, (y+frameCount) *nFac) * nAmm;
    strokeW = noiseAlgo3 + STROKEW/5;
  }


  // Mouse click motion
  void motion(float nAmm) {
    angle += noise(x*0.005, y*0.005) * nAmm;
    //angle += noise(x*0.005, y*0.005) * nAmm;
    x += cos(angle*0.05) * 3;
    y += sin(angle*0.05) * 3;
  }

  ////////////////////////////////////////// GRAPHIC
  void displayDots() {
    c = g.get(int(x), int(y));
    if ((c >= color(0)) && (c <= color(30))) {

      if (isStrokeC) {
        noFill();
        strokeWeight(STROKEC);
        stroke( HUE, SAT, BRIGHTNESS );
      } else {
        noStroke();
        fill(HUE, SAT, BRIGHTNESS);
      }
     // noStroke();
     // fill(HUE, SAT, BRIGHTNESS);
      pushMatrix();
      translate(x, y);
      rotate( angle+THETA_CIRCLES );
      if (SYMMETRIC) {
        // Experimental form : See function below
        //circularForm(0,0,10,30,DIA+dia);
        ellipse(0, 0, DIA+dia, DIA+dia);
      } else {
        ellipse(0, 0, DIAX+dia, DIAY+dia); // PLUS dia Here ?
      }
      popMatrix();
    }
  }

  void displayLines() {  
    xSpeed = ((width/2) - mouseX)/10.0f;
    ySpeed = ((height/2) - mouseY)/10.0f;

    xCount += xSpeed;
    yCount += ySpeed;  
    c = g.get(int(x), int(y));
    if ((c >= color(0)) && (c <= color(30))) {
      noFill();
      strokeWeight(strokeW);
      strokeCap(SQUARE);
      stroke(HUE2, SAT2, BRIGHTNESS2);

      pushMatrix();
      translate(x, y);

      // PERLIN NOISE ANGLE
      if (NOISE_THETA_LINE) {
        float snx = sin(angle * 0.005) * 30; // Smoother
        float sny = sin(angle * 0.005) * 30; // Smoother

        float pr = noise(x * PL_SCALE + snx, y * PL_SCALE + sny) * PL_AMM;
        angle  = (-(pr * PI ))/180.0f;

        rotate( radians( pr ) + angle );
        xv = cos(angle) * speed;
        xv = cos(angle) * speed;

        rotate(angle);
        float lenX = xv / len;
        float lenY = yv / len;
        line (-lenX, -lenY, 0, 0);
      } else {
        //TL = ceil(THETA_LINE);
        //rotate(radians(TL));
        rotate(radians(ceil(THETALINE)));
        line (-len, -len, len, len);
      }

      popMatrix();
    }
  }
  // Another graphic form
  void circularForm(float _x, float _y, float _radius, float _step, float _dia) {
    noStroke();
    fill(HUE, SAT, BRIGHTNESS);
    float radius = _radius; // circle radius
    float angleStep = _step; // angle step = number of repetitions

    pushMatrix();
    translate(_x, _y);
    for (float deg =0; deg<=360; deg+=angleStep) {
      // Calculate our x & y positions on the circle
      float xPos = cos(radians(deg))*radius; 
      float yPos = sin(radians(deg))*radius;
      // Draw shape
      ellipse(xPos, yPos, _dia, _dia);
    }
    popMatrix();
  }



  // !!! NOT IMPLEMENTED YET !!! 16/10/2015
  void superPerlin() {
    if (x%noiseRes == 0 && y%noiseRes == 0) {
      noiseVal=noise((x - xCount)*noiseScale, (y - yCount)*noiseScale, noiseCount);
      float g = noiseVal*720.0f;

      theta = (-(g * PI))/180.0f;
      xv = cos(theta)  * speed;
      yv = sin(theta)  * speed;
    }
  }
}