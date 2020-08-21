// create vertex glyphs from fonts

final static int stepsize = 10; // less - more accuracy
final static int beams = 20; // more - more accuracy

final static int NONE = -1;
final static int shape_type = NONE; // or any shape type used in beginShape() function
final static boolean curve = true; // only with shape NONE

HashMap<String, ArrayList<PVector>> letters = new HashMap<String, ArrayList<PVector>>();
String alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!@#$%&?";

void setup() {
  size(600, 600);
  smooth(8);
  noStroke();

  prepareFonts();

  fill(5,55,75);
  frameRate(5);
}

int idx = 0;
void draw() {
  background(230,220,200);
  translate(width/2, height/2);
  rotate(random(-0.2,0.2));

  drawLetter(Character.toString(alph.charAt(idx))); 
  
  idx = (idx + 1) % alph.length();
}

void drawLetter(String letter) {
  ArrayList<PVector> l = letters.get(letter);
  if(shape_type == NONE) beginShape();
  else beginShape(shape_type);
  for (int i=0; i<l.size (); i++) {
    if(shape_type == NONE && curve) curveVertex(l.get(i).x, l.get(i).y);
    else vertex(l.get(i).x, l.get(i).y);
  }
  endShape(CLOSE);
}

void prepareFonts() {
  fill(0);
  // PFont font = loadFont("CourierNewPS-BoldMT-200.vlw");
  // textFont(font,500);
  textSize(500);
  textAlign(CENTER, CENTER);
  ArrayList<PVector> l;
  for (int idx=0; idx<alph.length (); idx++) {
    background(255);
    text(String.valueOf(alph.charAt(idx)), width/2, height/2-50);

    l = new ArrayList<PVector>();
    for (float th=0; th<=TWO_PI; th+=TWO_PI/beams) {
      float r = 290;
      float b = 255;
      int nx=0, ny=0;
      while (b>128) { 
        nx = width/2+(int)(-r * sin(th));
        ny = height/2+(int)(r * cos(th));
        b = brightness(get((int)nx, (int)ny));
        r-=stepsize;
      }
      l.add(new PVector(nx-width/2, ny-height/2));
    }
    l.add(l.get(0));
    letters.put(String.valueOf(alph.charAt(idx)), l);
  }
}