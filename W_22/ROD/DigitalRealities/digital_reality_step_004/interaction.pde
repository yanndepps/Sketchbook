void interactionKeyboard() {
  if (keyPressed) {
    if (key == 'w') {
      cameraZ += speed;
    } else if (key == 's') {
      cameraZ -= speed;
    }
  }
}
