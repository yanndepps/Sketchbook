// Variations on Fractal Flames : Part_01
// https://generateme.wordpress.com/2016/04/11/folds/
// a grid, resulting of rounding floating point values.

float x1, y1, x2, y2; // function domain
float step; // step within domain
float y;
boolean go = true;

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
  float xx = map( x, x1, x2, 20, width-20 );
  float yy = map( y, y1, y2, 20, height-20 );
  point( xx, yy );
}
