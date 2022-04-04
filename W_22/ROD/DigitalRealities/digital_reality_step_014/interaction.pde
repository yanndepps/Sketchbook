void interactionKeyboard() {
  if (keyPressed) {
    if (key == 'w') {
      cameraZ += speed;
    } else if (key == 's') {
      cameraZ -= speed;
    } else if(key == 'p'){
     saveFrame("out/" + nf(int(random(1000000)),7) + ".png"); 
    }
  }
}
