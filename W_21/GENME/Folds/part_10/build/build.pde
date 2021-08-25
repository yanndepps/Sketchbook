// Variations on Fractal Flames : Part_10
// https://generateme.wordpress.com/2016/04/11/folds/
// a differential of pdj function

float x1, y1, x2, y2; // function domain
float step; // step within domain
float y;
boolean go = true;

// parameterization P={pdj_a,pdj_b,pdj_c,pdj_d}
float pdj_a = 1.0111;
float pdj_b = -1.011;
float pdj_c = 2.8;
float pdj_d = 10.2;

// sech parameters
float cosh(float x) { return 0.5 * (exp(x) + exp(-x)); }
float sinh(float x) { return 0.5 * (exp(x) - exp(-x)); }

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
  /* v = pdj(v, amount); */
  /* v = julia( v, amount ); */
  /* v = sech( v, amount ); */

  // combinations 
  // julia o sech
  /* v = julia(sech(v, amount), amount); */

  // power is a multiple combination of the same function
  /* for (int i=0; i<5; i++) { */
  /*   v = hyperbolic(v, amount); */
  /* } */

  v = d_pdj(v, amount);

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

// differential of a pdj
PVector d_pdj( PVector v, float amount ) {
  float h = 0.1; // step
  float sqrth = sqrt(h);
  PVector v1 = pdj(v, amount);
  PVector v2 = pdj(new PVector(v.x+h, v.y+h), amount);
  return new PVector( (v2.x-v1.x)/sqrth, (v2.y-v1.y)/sqrth );
}

PVector julia( PVector v, float amount ) {
  float r = amount * sqrt( v.mag() );
  float theta = 0.5 * atan2( v.x, v.y ) + (int)( 2.0 * random( 0, 1 ) ) * PI;
  float x = r * cos( theta );
  float y = r * sin( theta );
  return new PVector( x, y );
}

PVector sech( PVector p, float weight ) {
  float d = cos( 2.0 * p.y ) + cosh( 2.0 * p.x );
  if ( d != 0 ) d = weight * 2.0 / d;
  return new PVector( d * cos(p.y) * cosh(p.x), -d * sin(p.y) * sinh(p.x) );
}

// sum, substraction, multiplication and division of previous functions
PVector addF(PVector v1, PVector v2) {return new PVector(v1.x + v2.x, v1.y + v2.y);}
PVector subF(PVector v1, PVector v2) {return new PVector(v1.x - v2.x, v1.y - v2.y);}
PVector mulF(PVector v1, PVector v2) {return new PVector(v1.x * v2.x, v1.y * v2.y);}
PVector divF(PVector v1, PVector v2) {return new PVector(v2.x == 0 ? 0 : v1.x / v2.x, v2.y == 0 ? 0 : v1.y / v2.y);}
