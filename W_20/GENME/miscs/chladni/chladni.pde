// GenerateMe
// chladni pattern generator
// press space to save
// click to random change

float b1 = 1;
float b2 = 1;
float b3 = 1;
float b4 = 1;
float b5 = 1;
float b6 = -1;

float a1 = 3;
float a2 = 3;
float a3 = 5;
float a4 = 8;
float a5 = 10;
float a6 = 13;

final static float thr = 1.0e-1;

int expr_no = 6; // 1 to 6

void setup() {
  size(500, 500);
  smooth(8);
  noStroke();

  expr_no = constrain(expr_no,1,6);

  drawMe();
}

float s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12;

void drawMe() {
  background(255);
  for (int xx=0;xx<width;xx++) {
    float x = map(xx, 0, width-1, 0, PI);
    if(expr_no>0) s1 = sin(a1 * x);
    if(expr_no>1) s3 = sin(a2 * x);
    if(expr_no>2) s5 = sin(a3 * x);
    if(expr_no>3) s7 = sin(a4 * x);
    if(expr_no>4) s9 = sin(a5 * x);
    if(expr_no>5) s11 = sin(a6 * x);
    for (int yy=0;yy<height;yy++) {
      float y = map(yy, 0, height-1, 0, PI);
      if(expr_no>0) s2 = sin(a2 * y);
      if(expr_no>1) s4 = sin(a1 * y);
      if(expr_no>2) s6 = sin(a4 * y);
      if(expr_no>3) s8 = sin(a3 * y);
      if(expr_no>4) s10 = sin(a6 *y);
      if(expr_no>5) s12 = sin(a5 * y);

      float res = 0;
      switch(expr_no) {
        case 6: res+=b6 * s11 * s12;
        case 5: res+=b5 * s9 * s10;
        case 4: res+=b4 * s7 * s8;
        case 3: res+=b3 * s5 * s6;
        case 2: res+=b2 * s3 * s4;
        case 1: res+=b1 * s1 * s2;
      }

      int b = constrain( (int)map(res, -1.2, 1.2, 0, 255), 0, 255 );
      if (abs(res)<thr) { 
        fill(0);
        ellipse(xx, yy, 1.5, 1.5);
      }  
      else { 
        fill(b);
        rect(xx, yy, 1, 1);
      }
    }
  }
}

void draw() {
}

void mouseClicked() {
  b1 = random(-1, 1);
  b2 = random(-1, 1);
  b3 = random(-1, 1);
  b4 = random(-1, 1);
  b5 = random(-1, 1);
  b6 = random(-1, 1);

  a1 = random(0.1, 20);
  a2 = random(0.1, 20);
  a3 = random(0.1, 20);
  a4 = random(0.1, 20);
  a5 = random(0.1, 20);
  a6 = random(0.1, 20);
  
  expr_no = (int)random(6)+1;
  
  drawMe();
}

void keyPressed() {
  save("result_"+hex((int)random(0xffffff+1)) + ".jpg");
  println("saved");
}
