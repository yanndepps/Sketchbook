void drawScene() {

  // create the dome / sky
  scene.fill(#0000FF);
  scene.noStroke();
  scene.push();
  scene.translate(scene.width/2, scene.height/2);
  scene.rotateY(radians(frameCount * 0.01));
  scene.texture(tex);
  scene.shape(globe);
  scene.pop();

  // Create the floor
  
  scene.fill(FG);
  scene.noStroke();
  scene.push();
  scene.translate(scene.width/2, scene.height/2 + 200, cameraZ);
  scene.rotateY(radians(90 + mx));
  scene.rotateX(radians(90));
  scene.push();
  scene.fill(BG);
  scene.translate(0, 20);
  scene.textureMode(NORMAL); 
  scene.beginShape();
  scene.texture(floor);
  scene.vertex(-MAGNITUDE, -MAGNITUDE, 0, 0);
  scene.vertex(MAGNITUDE, -MAGNITUDE, 1, 0);
  scene.vertex(MAGNITUDE, MAGNITUDE, 1, 1);
  scene.vertex(-MAGNITUDE, MAGNITUDE, 0, 1);
  scene.endShape();
  scene.pop();

  // Distribute the videowalls
  for (int i = 0; i < walls.size(); i++) {

    Videowall W = walls.get(i);

    scene.push();
    scene.translate(W.Z, W.X, 420);
    scene.rotateX(radians(-90));
    scene.rotateY(radians(W.ROT));
    W.display();
    scene.image(W.pg, 0, 0);
    scene.pop();
  }


  scene.pop();
}
