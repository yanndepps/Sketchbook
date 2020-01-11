BufferedReader reader;
String line;

class Vertex{
 float x,y,z;
 
 Vertex(float x, float y, float z){
  this.x=x;
  this.y=y;
  this.z=z;
 } 
 
 void drawVertex(){
  vertex(x,y,z); 
 }
}

class Face{
  int[] indices;
  int numberOfVertices;
  
  Face(int[] indices){
    this.indices=indices;
    numberOfVertices=indices.length;
  } 
  
  void drawFace(){
   beginShape();
   for(int i=0;i<numberOfVertices;i++){
     vertices.get(indices[i]).drawVertex();
   }   
   endShape();  
  }
}

ArrayList<Vertex> vertices;
ArrayList<Face> faces;

void setup() {  
  size(800,800,P3D);
  smooth(8);
  readFile("pyramid.obj");
}

void readFile(String file) {
  vertices=new ArrayList<Vertex>();
  faces=new ArrayList<Face>();
  reader = createReader(file);
  do {
    try {
      line = reader.readLine();
    } 
    catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
    if (line == null) {
      return;
    } else {
     processLine(line);
    }
  } while (true);
}

void processLine(String line){
  String[] parts=splitTokens(line," ");
  if(parts[0].equals("v")){
    addVertex(parts);
  }else if(parts[0].equals("f")){
    addFace(parts);
  } else{
   //doNothing
  }
}

void addVertex(String[] parts){
  Vertex vertex=new Vertex(float(parts[1]),float(parts[2]),float(parts[3]));
  vertices.add(vertex);
}

void addFace(String[] parts){
   int numberOfVertices=parts.length-1;
   String part;
   String[] subParts;
   int[] indices=new int[numberOfVertices];
   for(int i=0;i<numberOfVertices;i++){
     part=parts[i+1];
     subParts=splitTokens(part,"/");
     indices[i]=int(subParts[0])-1;
   }
   Face face= new Face(indices);
   faces.add(face);
 }
 
 void draw(){
   background(245);
   translate(width/2, height/2);
   lights();
   rotateY(map(mouseX,0,width,-PI,PI));
   rotateX(map(mouseY,0,height,PI,-PI));
   scale(200);
   strokeWeight(0.01);
   for(Face face:faces){
     face.drawFace();
   }  
 }
