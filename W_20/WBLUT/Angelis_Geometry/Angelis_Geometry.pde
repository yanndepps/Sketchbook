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
PShape tentacleShape;
void setup() {
  fullScreen(P3D);
  smooth(16);
  render=new WB_Render3D(this);
  create();
}

void create() {
  baseMesh = new HE_Mesh(new HEC_Torus(280, 720, 3, 7));
  println("Created baseMesh.");
  baseMesh.modify(new HEM_Lattice().setWidth(100).setDepth(50));
  println("Created lattice.");
  baseMesh.smooth(3);
  println("Subdivided lattice.");
  baseMesh.modify(new HEM_Dual());
  println("Dual baseMesh created.");
  graph = new HET_MeshGraph(baseMesh); 
  network = graph.getNetwork(0, 128);
  network.smoothNodes();
  network.smoothNodes();
  network.smoothBiNodes();
  println("Network created.");
  HEC_FromNetwork creator = new HEC_FromNetwork();
  creator.setNetwork(network);
  creator.setConnectionRadius(20 ).setConnectionFacets(5)
    .setMaximumConnectionLength(40 ).setMaximumConnectionOffset(18 ).setCap(true)
    .setTaper(true).setCreateIsolatedNodes(false).setUseNodeValues(true);
  tentacleMesh = new HE_Mesh(creator);
  tentacleMesh.removeUnconnectedElements();
  tentacleMesh.clean();
  println("Network mesh created.");
  tentacleMesh.modify(new HEM_TaubinSmooth().setIterations(10));
  println("Network mesh smoothed.");
  tentacleShape=WB_PShapeFactory.createSmoothPShape(tentacleMesh,this);
  tentacleShape.disableStyle();
  println("Tentacle shape created.");
}


void draw() {
  background(15);
  lights();
  translate(width/2, height/2);
  rotateX(map(mouseY,0,height,PI,-PI));
  rotateY(map(mouseX,0,width,-PI,PI));
  scale(0.4);
  fill(255);
  noStroke();
  shape(tentacleShape);
}
