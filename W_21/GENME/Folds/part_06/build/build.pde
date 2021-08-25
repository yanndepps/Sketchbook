// Variations on Fractal Flames : Part_06
// https://generateme.wordpress.com/2016/04/11/folds/
// PDJ with new parameters

float x1, y1, x2, y2; // function domain
float step; // step within domain
float y;
boolean go = true;

// parameterization P={pdj_a,pdj_b,pdj_c,pdj_d}
float pdj_a = 1.0111;
float pdj_b = -1.011;
float pdj_c = 2.8;
float pdj_d = 10.2;

void setup() {
  size(600, 600);
  background(250);
  smooth(8);
  noFill();
  stroke(20, 15);
  strokeWeight(0.9);

  x1 = y1 = -3;
  x2 = y2 = 3;
  y = y1;
  step = ( x2 - x1 ) / ( 2.321 * width );
}

void draw() {
  if (go) {
    for ( int i = 0; ( i < 20 )&go; i++ ) { // draw 20 lines at once
      for ( float x = x1; x <= x2; x += step ) {
        drawVariation(x, y);
      }
      y += step;
      if ( y > y2 ) {
        go = false;
        println( "done" );
      }
    }
  }
}

void drawVariation( float x, float y ) {
  PVector v = new PVector(x, y);
  float amount = 1.0;

  /* v = sinusoidal(v, amount); */
  /* v = hyperbolic(v, amount); */
  v = pdj(v, amount);

  float xx = map( v.x+0.003*randomGaussian(), x1, x2, 20, width-20 );
  float yy = map( v.y+0.003*randomGaussian(), y1, y2, 20, height-20 );
  point( xx, yy );
}

PVector sinusoidal(PVector v, float amount) {
  return new PVector( amount * sin( v.x ), amount * sin( v.y ) );
}

PVector hyperbolic( PVector v, float amount ) {
  float r = v.mag() + 1.0e-10;
  float theta = atan2( v.x, v.y );
  float x = amount * sin( theta ) / r;
  float y = amount * cos( theta ) * r;
  return new PVector( x, y );
}

PVector pdj( PVector v, float amount ) {
  return new PVector( 
    amount * ( sin( pdj_a * v.y ) - cos( pdj_b * v.x ) ),
    amount * ( sin( pdj_c * v.x ) - cos( pdj_d * v.y ) )
      );
}
