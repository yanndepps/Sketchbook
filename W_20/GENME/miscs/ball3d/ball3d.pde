// http://generateme.tumblr.com

final static int off = 1000; // set between 0 to 4500 to see related timeframes
final static boolean doblur = false ;
final static float ystep = TWO_PI/700.0;
final static float xstep = TWO_PI/500.0;

void setup() {
  size(800,800,P3D);
  smooth(8);
  noStroke();
}

final static float mang = 2*TWO_PI;

void draw() {
  int fc = frameCount + off;
  println(fc);
  fill(19,19,10,map(fc,1,5000,200,1));
  rect(0,0,width,height);
  if(doblur) filter(BLUR,1);
  
  fill(220);
  lights();
  ambient(lerpColor( color(18,49,66), color(255), map(frameCount+off,0,5000,0,1)));
  shininess(1.0);

  translate(width/2, height/2); 
  rotateY(PI+fc*ystep);
  rotateX(HALF_PI+fc*xstep);
  
  float sss = fc/70.0; // time factor

  beginShape(TRIANGLE_STRIP);
  // how many vertices
  for(int i=0;i<(2000-0.4*fc);i++) {
    
    // ribbon definition
    float lambda = mang * noise(sss*0.2,i/sss,(map(i,0,1000,0,TWO_PI)));
    float delta =  mang * noise((map(i,0,1000,0,TWO_PI)),i/sss,-sss*0.2);
       
    float cl = cos(lambda);
    float cd = cos(delta);
    float sl = sin(lambda);
    float sd = sin(delta);
    
    // sphere radius
    float mag = 200+100*noise(lambda,delta,sss);

    // convert to sphere
    float x = mag*cl*cd;
    float y = mag*sl*cd;
    float z = mag*sd;
    
    vertex(x,y,z);
  }
  endShape(CLOSE);
//  if(fc<5200) { saveFrame("res/######.jpg"); }
}