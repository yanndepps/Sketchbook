
void drawBinaryGridOutline3D(final BinaryGrid3D grid) {
  pushMatrix();
  translate(grid.min.x, grid.min.y, grid.min.z);
  drawXEdges(grid);
  drawYEdges(grid);
  drawZEdges(grid);
  popMatrix();
}

void drawBinaryGrid3D(final BinaryGrid3D grid) {
  pushMatrix();
  translate(grid.min.x, grid.min.y, grid.min.z);
  drawXFaces(grid);
  drawYFaces(grid);
  drawZFaces(grid);
  popMatrix();
}

void drawBinaryGrid3D(final BinaryGrid3D grid, final int colorX, final int colorY, final int colorZ) {
  pushStyle();
  pushMatrix();
  translate(grid.min.x, grid.min.y, grid.min.z);
  fill(colorX);
  drawXFaces(grid);
  fill(colorY);
  drawYFaces(grid);
  fill(colorZ);
  drawZFaces(grid);
  popMatrix();
  popStyle();
}

void drawBinaryGridOutline3D(final BinaryGrid3D grid, final int colorX, final int colorY, final int colorZ) {
  pushStyle();
  pushMatrix();
  translate(grid.min.x, grid.min.y, grid.min.z);
  stroke(colorX);
  drawXEdges(grid);
  stroke(colorY);
  drawYEdges(grid);
  stroke(colorZ);
  drawZEdges(grid);
  popMatrix();
  popStyle();
}

void drawXEdges(final BinaryGrid3D grid) {
  int val00, valm0, valmm, val0m, sum;
  float x, y, z;
  for (int i = grid.lX(); i < grid.uX(); i++) {
    x = i * grid.getDX();
    for (int j = grid.lY(); j <= grid.uY(); j++) {
      y = j * grid.getDY();
      for (int k = grid.lZ(); k <= grid.uZ(); k++) {
        z = k * grid.getDZ();
        val00 = grid.get(i, j, k) ? 1 : 0;
        valm0 = grid.get(i, j - 1, k) ? 1 : 0;
        valmm = grid.get(i, j - 1, k - 1) ? 1 : 0;
        val0m = grid.get(i, j, k - 1) ? 1 : 0;
        sum = val00 + valm0 + valmm + val0m;
        if (sum == 1 || sum == 3) {
          line(x, y, z, x + grid.getDX(), y, z);
        }
        if (sum == 2) {
          if (val00 + valmm == 2 || val0m + valm0 == 2) {
            line(x, y, z, x + grid.getDX(), y, z);
          }
        }
      }
    }
  }
}


void drawXFaces(final BinaryGrid3D grid) {
  int val0, valm, sum;
  float x, y, z;
  for (int i = grid.lX(); i <= grid.uX(); i++) {
    x = i * grid.getDX();
    for (int j = grid.lY(); j < grid.uY(); j++) {
      y = j * grid.getDY();
      for (int k = grid.lZ(); k < grid.uZ(); k++) {
        z = k * grid.getDZ();
        val0 = grid.get(i, j, k) ? 1 : 0;
        valm = grid.get(i - 1, j, k) ? 1 : 0;
        sum = val0 + valm;
        if (sum == 1) {
          beginShape();
          vertex(x, y, z);
          vertex(x, y + grid.getDY(), z);
          vertex(x, y + grid.getDY(), z + grid.getDZ());
          vertex(x, y, z + grid.getDZ());
          endShape();
        }
      }
    }
  }
}

void drawYEdges(final BinaryGrid3D grid) {
  int val00, valm0, valmm, val0m, sum;
  float x, y, z;
  for (int j = grid.lY(); j < grid.uY(); j++) {
    y = j * grid.getDY();
    for (int i = grid.lX(); i <= grid.uX(); i++) {
      x = i * grid.getDX();
      for (int k = grid.lZ(); k <= grid.uZ(); k++) {
        z = k * grid.getDZ();
        val00 = grid.get(i, j, k) ? 1 : 0;
        valm0 = grid.get(i - 1, j, k) ? 1 : 0;
        valmm = grid.get(i - 1, j, k - 1) ? 1 : 0;
        val0m = grid.get(i, j, k - 1) ? 1 : 0;
        sum = val00 + valm0 + valmm + val0m;
        if (sum == 1 || sum == 3) {
          line(x, y, z, x, y + grid.getDY(), z);
        }
        if (sum == 2) {
          if (val00 + valmm == 2 || val0m + valm0 == 2) {
            line(x, y, z, x, y + grid.getDY(), z);
          }
        }
      }
    }
  }
}

void drawYFaces(final BinaryGrid3D grid) {
  int val0, valm, sum;
  float x, y, z;
  for (int i = grid.lX(); i < grid.uX(); i++) {
    x = i * grid.getDX();
    for (int j = grid.lY(); j <= grid.uY(); j++) {
      y = j * grid.getDY();
      for (int k = grid.lZ(); k < grid.uZ(); k++) {
        z = k * grid.getDZ();
        val0 = grid.get(i, j, k) ? 1 : 0;
        valm = grid.get(i, j - 1, k) ? 1 : 0;
        sum = val0 + valm;
        if (sum == 1) {
          beginShape();
          vertex(x, y, z);
          vertex(x + grid.getDX(), y, z);
          vertex(x + grid.getDX(), y, z + grid.getDZ());
          vertex(x, y, z + grid.getDZ());
          endShape();
        }
      }
    }
  }
}

void drawZEdges(final BinaryGrid3D grid) {
  int val00, valm0, valmm, val0m, sum;
  float x, y, z;
  for (int k = grid.lZ(); k < grid.uZ(); k++) {
    z = k * grid.getDZ();
    for (int j = grid.lY(); j <= grid.uY(); j++) {
      y = j * grid.getDY();
      for (int i = grid.lX(); i <= grid.uX(); i++) {
        x = i * grid.getDX();
        val00 = grid.get(i, j, k) ? 1 : 0;
        valm0 = grid.get(i - 1, j, k) ? 1 : 0;
        valmm = grid.get(i - 1, j - 1, k) ? 1 : 0;
        val0m = grid.get(i, j - 1, k) ? 1 : 0;
        sum = val00 + valm0 + valmm + val0m;
        if (sum == 1 || sum == 3) {
          line(x, y, z, x, y, z + grid.getDZ());
        }
        if (sum == 2) {
          if (val00 + valmm == 2 || val0m + valm0 == 2) {
            line(x, y, z, x, y, z + grid.getDZ());
          }
        }
      }
    }
  }
}

void drawZFaces(final BinaryGrid3D grid) {
  int val0, valm, sum;
  float x, y, z;
  for (int i = grid.lX(); i < grid.uX(); i++) {
    x = i * grid.getDX();
    for (int j = grid.lY(); j < grid.uY(); j++) {
      y = j * grid.getDY();
      for (int k = grid.lZ(); k <= grid.uZ(); k++) {
        z = k * grid.getDZ();
        val0 = grid.get(i, j, k) ? 1 : 0;
        valm = grid.get(i, j, k - 1) ? 1 : 0;
        sum = val0 + valm;
        if (sum == 1) {
          beginShape();
          vertex(x, y, z);
          vertex(x + grid.getDX(), y, z);
          vertex(x + grid.getDX(), y + grid.getDY(), z);
          vertex(x, y + grid.getDY(), z);
          endShape();
        }
      }
    }
  }
}
