size(1000,1000);
background(20);
smooth(8);
noFill();
stroke(240);
strokeWeight(0.7);

// outer circle
ellipse(500,500,900,900);

// middle circle
// very small steps are needed with vertex
// experiment with step eg. float step = TWO_PI/50.0;
float step = TWO_PI/(4.0*360.0);
float r = 400.0;
float ang = 0;

beginShape();
while(ang<TWO_PI) {
  float x = cos(ang) * r;
  float y = sin(ang) * r;
  vertex(x+500,y+500);
  ang+=step;
}
endShape(CLOSE);

// inner circle
ang = 0;
r = 350;
// experiment with step eg. step = TWO_PI/5;
step = TWO_PI/17;

beginShape();
// here we need to overlap curveVertexes to close circle change following '3' to '2' to see what happen
while(ang<=TWO_PI+3*step) {
  float x = cos(ang) * r;
  float y = sin(ang) * r;
  curveVertex(x+500,y+500);
  ang+=step;
}
endShape(); // do not close, just overlap curveVertexes.