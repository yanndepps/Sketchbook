//matcap texture from https://github.com/hughsk/matcap

import wblut.core.*;
import wblut.geom.*;
import wblut.hemesh.*;
import wblut.math.*;
import wblut.nurbs.*;
import wblut.processing.*;

WB_Render3D render;

HE_Mesh baseMesh, tentacleMesh;
HET_MeshGraph graph;
WB_Network network;

float scale;
PShape tentacleShape, baseEdges;
PShader matcap, mirror;
float startTime;
float elapsedTime;
float ax,ay;
void setup() {
  //fullScreen(P3D);
  size(800, 800, P3D);
  smooth(16);
  render=new WB_Render3D(this);
  matcap = loadShader("shaders/MatCapFrag.glsl", "shaders/MatCapVert.glsl");  
  matcap.set("mctexture", loadImage("matcap/m5.jpg"));
  mirror = loadShader("shaders/mirrorxy.glsl");
  create();
  startTime =millis();
  elapsedTime = 0;
}

void create() {
  baseMesh = new HE_Mesh(new HEC_Torus(280, 720, 3, 7));
  println("Created baseMesh.");
  baseMesh.modify(new HEM_Lattice().setWidth(160).setDepth(160));
  println("Created lattice.");
  baseMesh.smooth(3);
  println("Subdivided lattice.");
  baseMesh.modify(new HEM_Dual());
  baseEdges=WB_PShapeFactory.createWireframePShape(baseMesh, this);
  baseEdges.disableStyle();
  println("Dual baseMesh created.");
  graph = new HET_MeshGraph(baseMesh); 
  network = graph.getNetwork(0, 128);
  network.smoothNodes();
  network.smoothNodes();
  network.smoothBiNodes();
  println("Network created.");
  HEC_FromNetwork creator = new HEC_FromNetwork();
  creator.setNetwork(network);
  creator.setConnectionRadius(10 ).setConnectionFacets(5)
    .setMaximumConnectionLength(40 ).setMaximumConnectionOffset(12 ).setCap(true)
    .setTaper(true).setCreateIsolatedNodes(false).setUseNodeValues(true);
  tentacleMesh = new HE_Mesh(creator);
  tentacleMesh.removeUnconnectedElements();
  tentacleMesh.clean();
  println("Network mesh created.");

  tentacleMesh.modify(new HEM_TaubinSmooth().setIterations(10));
  println("Network mesh smoothed.");
  tentacleShape=WB_PShapeFactory.createSmoothPShape(tentacleMesh, this);
  tentacleShape.disableStyle();

  println("Tentacle shape created.");
}


void draw() {
  elapsedTime = 0.001*(millis()-startTime);
  ax = 2.4*elapsedTime;//2.4° per s
  ay = 0.9*elapsedTime;//0.9° per s
  background(15);
  lights();

  translate(width / 2, height / 2);
  rotateZ(radians(elapsedTime*6.0));//6.0° per s
  scale(0.4);
  shader(matcap);
  
  draw(ax,ay,color(0,255,255,60));
  draw(0.7*ax,1.3*ay,color(255,0,255,60));
  draw(1.3*ax,0.7*ay,color(255,255,0,60));
  filter(mirror); 
}

void draw(float ax, float ay, color strokeColor){
  pushMatrix();
  rotateY(radians(ay));
  rotateX(radians(ax));
  noStroke();
  shape(tentacleShape);
  stroke(strokeColor);
  shape(baseEdges);
  popMatrix();
}
