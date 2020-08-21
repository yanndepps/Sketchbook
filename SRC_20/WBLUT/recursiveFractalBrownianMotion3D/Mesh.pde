class Mesh {
  int[] faces;
  float[][] vertices;
  
  Mesh(int[] faces, float[][] vertices, float scale) {
    this.faces=new int[faces.length];
    for (int i=0; i<faces.length; i++) {
      this.faces[i]=faces[i];
    }
    this.vertices=new float[vertices.length][3];
    for (int i=0; i<vertices.length; i++) {
      this.vertices[i][0]=vertices[i][0]*scale; 
      this.vertices[i][1]=vertices[i][1]*scale; 
      this.vertices[i][2]=vertices[i][2]*scale;
    }
  }

  Mesh copy(float scale) {
    return new Mesh(faces, vertices, scale);
  }

  PShape getShape() {
    PShape shape=createShape();
    int v;
    shape.beginShape(TRIANGLES);
    for (int i=0; i<faces.length; i++) {
      v=faces[i];
      shape.vertex(vertices[v][0], vertices[v][1], vertices[v][2]);
    }
    shape.endShape();
    return shape;
  }
}
