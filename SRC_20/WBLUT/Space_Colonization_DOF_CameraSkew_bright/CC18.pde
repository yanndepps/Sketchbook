// Coding Rainbow
// Daniel Shiffman
// http://patreon.com/codingtrain
// Code for: https://youtu.be/JcopTKXt8L8

class Branch {
  Branch parent;
  PVector pos;
  PVector dir;
  int count = 0;
  PVector saveDir;
  float len = 10;
  boolean active;
  int age;
  Branch(PVector v, PVector d, int age) {
    parent = null;
    pos = v.copy();
    dir = d.copy();
    saveDir = dir.copy();
    active=true;
    this.age=age;
  }

  Branch(Branch p, int age) {
    parent = p;
    pos = parent.next();
    dir = parent.dir.copy();
    saveDir = dir.copy();
    this.age=age;
  }

  void reset() {
    count = 0;
    dir = saveDir.copy();
  }

  PVector next() {
    PVector v = PVector.mult(dir, len);
    PVector next = PVector.add(pos, v);
    return next;
  }
}

// Coding Rainbow
// Daniel Shiffman
// http://patreon.com/codingtrain
// Code for: https://youtu.be/JcopTKXt8L8


class Leaf {
  PVector pos;
  boolean reached = false;
  int index;
  Leaf(int index) {
    this.index=index;
    pos = PVector.random3D();
    pos.mult(random(100, 400.0));
  }

  void reached() {
    reached = true;
  }

  void show() {
    if (reached) {
      pushMatrix();
      translate(pos.x, pos.y, pos.z); 
      rotateX(-ax);
      rotateY(-ay);
      scale(1.2+0.8*cos(radians(index)));
      image(sprite, 0, 0);
      popMatrix();
    }
  }
}

// Coding Rainbow
// Daniel Shiffman
// http://patreon.com/codingtrain
// Code for: https://youtu.be/JcopTKXt8L8


class Tree {
  ArrayList<Branch> branches = new ArrayList<Branch>();
  ArrayList<Leaf> leaves = new ArrayList<Leaf>();
  int age;
  Tree() {
    age=0;
    for (int i = 0; i <2000; i++) {
      leaves.add(new Leaf(i));
    }    
    Branch root = new Branch(new PVector(0, 0), new PVector(0, -1), age);
    branches.add(root);
    Branch current = new Branch(root, age);

    while (!closeEnough(current)) {
      Branch trunk = new Branch(current, age++);
      branches.add(trunk);
      current = trunk;
    }
  }

  boolean closeEnough(Branch b) {

    for (Leaf l : leaves) {
      float d = PVector.dist(b.pos, l.pos);
      if (d < max_dist) {
        return true;
      }
    }
    return false;
  }

  void grow() {
    age++;

    for (Leaf l : leaves) {
      if (!l.reached) {
        Branch closest = null;
        PVector closestDir = null;
        float record = -1;

        for (Branch b : branches) {

          PVector dir = PVector.sub(l.pos, b.pos);
          float d = dir.mag();
          if (d < min_dist) {
            l.reached();
            closest = null;
            break;
          } else if (d > max_dist) {
            //do nothing
          } else if (closest == null || d < record) {
            closest = b;
            closestDir = dir;
            record = d;
          }
        }
        if (closest != null) {
          closestDir.normalize();
          closest.dir.add(closestDir);
          closest.count++;
        }
      }
    }


    for (int i = branches.size()-1; i >= 0; i--) {
      Branch b = branches.get(i);
     
        if (b.count > 0) {
          b.dir.div(b.count);
          b.dir.normalize();
          b.dir=findClosestDirection(b.dir);
          Branch newB = new Branch(b, age);
          branches.add(newB);
          b.reset();
        }
      
    }
  }

  PVector findClosestDirection(PVector v) {
    PVector closest=directions[0];
    float dot= closest.dot(v);
    PVector test;
    float dotTest;
    for (int i=1; i<directions.length; i++) {
      test=directions[i];
      dotTest=test.dot(v);
      if (dotTest>dot) {
        closest=test;
        dot=dotTest;
      }
    }
    return closest;
  }

  void show() {
    hint(ENABLE_DEPTH_MASK);
    blendMode(BLEND);
    for (int i = 0; i < branches.size(); i++) {
      Branch b = branches.get(i);
      if (b.parent != null) {
        stroke(255);
        line(b.pos.x, b.pos.y, b.pos.z, b.parent.pos.x, b.parent.pos.y, b.parent.pos.z);
      }
    }
    hint(DISABLE_DEPTH_MASK);
    blendMode(ADD);
    for (int l=0; l<leaves.size()/2; l++) {
      leaves.get(l).show();
    }
  }
}
