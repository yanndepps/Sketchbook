import de.looksgood.ani.*;
import controlP5.*;

ControlP5 cp5;
float a1,a2;
void setup() {
  size(400, 400);
  cp5 = new ControlP5(this);
  cp5.addSlider("a1").setSize(200, 20).setPosition(20, 20);
  cp5.addSlider("a2").setSize(200, 20).setPosition(20, 50);
  Ani.init(this);
}

void draw() {
  background(a2*2.5);
}

void keyPressed() {
  float duration = 1.5;
  String value = String.format( "value:%f", random(0,100) );
  Ani.to( route( "a1" ), duration, value, Ani.SINE_IN_OUT, "onUpdate:update" );
  Ani.to( route( "a2" ), duration, value, Ani.BOUNCE_IN_OUT, "onUpdate:update" );
}

void a1(float v) {
  println("updated a1 to",v);
}


Route route( String theId ) {
  return new Route( cp5.getController( theId ) );
}

class Route {
  final Controller c;
  float value;

  Route( Controller theController ) {
    c = theController;
    value = c.getValue( );
  }

  void update( ) {
    c.setValue( value );
  }
}

// --- END --- //