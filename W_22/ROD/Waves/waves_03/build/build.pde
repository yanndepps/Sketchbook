/*
 * shader as a texture
 */

PShader fx;
PShape cube;
PGraphics tex;

void setup() {
  size(640, 640, P3D);
  tex = createGraphics(200, 200, P3D);
  fx = loadShader("frag.glsl");
  tex.beginDraw();
  tex.shader(fx);
  tex.noStroke();
  tex.rect(0, 0, tex.width, tex.height);
  tex.endDraw();
  cube = makeCube();
  cube.setTexture(tex);
  fill(255);
  noStroke();
}

void draw() {
  fx.set("time", millis() * 0.01);
  tex.beginDraw();
  tex.rect(0, 0, tex.width, tex.height);
  tex.endDraw();
  background(33);
  translate(width/2, height/2, -100);
  rotateX(millis() * 0.001);
  rotateY(millis() * 0.0005);
  scale(90);
  shape(cube);
}

PShape makeCube() {
  PShape s = createShape();
  s.beginShape(QUADS);

  // +z "front" face
  s.vertex(-1, -1, 1, 0, 0);
  s.vertex(1, -1, 1, 1, 0);
  s.vertex(1, 1, 1, 1, 1);
  s.vertex(-1, 1, 1, 0, 1);

  // -z "back" face
  s.vertex(1, -1, -1, 0, 0);
  s.vertex(-1, -1, -1, 1, 0);
  s.vertex(-1, 1, -1, 1, 1);
  s.vertex(1, 1, -1, 0, 1);

  // +y "bootom" face
  s.vertex(-1, 1, 1, 0, 0);
  s.vertex(1, 1, 1, 1, 0);
  s.vertex(1, 1, -1, 1, 1);
  s.vertex(-1, 1, -1, 0, 1);

  // -y "top" face
  s.vertex(-1, -1, -1, 0, 0);
  s.vertex(1, -1, -1, 1, 0);
  s.vertex(1, -1, 1, 1, 1);
  s.vertex(-1, -1, 1, 0, 1);

  // +x "right" face
  s.vertex(1, -1, 1, 0, 0);
  s.vertex(1, -1, -1, 1, 0);
  s.vertex(1, 1, -1, 1, 1);
  s.vertex(1, 1, 1, 0, 1);

  // -x "left" face
  s.vertex(-1, -1, -1, 0, 0);
  s.vertex(-1, -1, 1, 1, 0);
  s.vertex(-1, 1, 1, 1, 1);
  s.vertex(-1, 1, -1, 0, 1);

  s.endShape();

  s.setStroke(false);
  s.setTextureMode(NORMAL);

  return s;
}
