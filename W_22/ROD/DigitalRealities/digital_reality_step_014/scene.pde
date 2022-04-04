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
  scene.translate(scene.width/2, scene.height/2 + 1200, cameraZ);
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
    scene.translate(W.Z, W.X, W.Y);
    scene.rotateX(radians(W.ROTX));
    scene.rotateY(radians(W.ROTY));
    scene.rotateZ(radians(W.ROTZ));
    W.display();
    scene.image(texture, 0, 0);
    scene.pop();
  }


  scene.pop();
}
