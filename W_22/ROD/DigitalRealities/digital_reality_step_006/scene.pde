void scene() {

  fill(#0000FF);
  noStroke();
  push();
  translate(width/2, height/2);
  rotateY(radians(frameCount * 0.01));
  texture(tex);
  shape(globe);
  pop();

  fill(FG);
  noStroke();

  push();
  translate(width/2, height/2 + 200, cameraZ);
  rotateX(radians(90));

  rectMode(CENTER);
  push();
  fill(BG);
  translate(0, 20);
  rect(0, 0, MAGNITUDE, MAGNITUDE);
  pop();

  for (int x = 0; x < TILES_X; x++) {
    for (int y = 0; y < TILES_Y; y++) {
      push();
      translate(tileW/2 - MAGNITUDE/2 + tileW * x, tileH / 2 - MAGNITUDE/2 + tileH * y);
      box(5);
      pop();
    }
  }


  for (int i = 0; i < walls.size(); i++) {
    
    Videowall W = walls.get(i);
    
    push();
    // translate(x, -z, 0);
    translate(W.Z, W.X, 300);
    rotateX(radians(-90));
    rotateY(radians(W.ROT));
    W.display();
    image(W.pg, 0, 0);
    pop();
  }


  pop();
}
