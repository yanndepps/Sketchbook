static abstract class BinaryGrid3D {
  int sizeX;
  int sizeY;
  int sizeZ;
  PVector center;
  PVector min;
  float dX, dY, dZ;
  int lX, uX, lY, uY, lZ, uZ;
  boolean invert;

  abstract void set(int x, int y, int z); 
  abstract void clear(int x, int y, int z);

  final boolean get(final int x, final int y, final int z) {
    if (x > lX - 1 && y > lY - 1 && z > lZ - 1 && x < uX && y < uY && z < uZ) {
      return (invert) ? !getInternal(x, y, z) : getInternal(x, y, z);
    } else {
      return false;
    }
  }

  abstract boolean getInternal(int x, int y, int z);

  int getSizeX() {
    return sizeX;
  }

  
  int getSizeY() {
    return sizeY;
  }

 
  int getSizeZ() {
    return sizeZ;
  }


  PVector getCenter() {
    return center;
  }

  PVector getMin() {
    return min;
  }

  float getDX() {
    return dX;
  }

  float getDY() {
    return dY;
  }

  float getDZ() {
    return dZ;
  }


  void setInvert(final boolean b) {
    this.invert = b;
  }


  private BinaryGrid3D() {
  }


  static BinaryGrid3D createGrid(final PVector c, final int sizeX, final float dX, final int sizeY,
      final float dY, final int sizeZ, final float dZ) {
    final BinaryGrid3D grid = new BinaryGridArray3D(c, sizeX, dX, sizeY, dY, sizeZ, dZ);
    return grid;
  }


  static BinaryGrid3D createGrid(final PVector c, final int sizeX, final float dX, final int sizeY,
      final float dY, final int sizeZ, final float dZ, final boolean[] values) {
    final BinaryGrid3D grid = new BinaryGridArray3D(c, sizeX, dX, sizeY, dY, sizeZ, dZ, values);
    return grid;
  }

  void setLimits(final int lX, final int uX, final int lY, final int uY, final int lZ, final int uZ) {
    this.lX = lX;
    this.uX = uX;
    this.lY = lY;
    this.uY = uY;
    this.lZ = lZ;
    this.uZ = uZ;
  }

  void clearLimits() {
    this.lX = 0;
    this.uX = sizeX;
    this.lY = 0;
    this.uY = sizeY;
    this.lZ = 0;
    this.uZ = sizeZ;
  }

  int lX() {
    return lX;
  }

  int uX() {
    return uX;
  }

  int lY() {
    return lY;
  }

  int uY() {
    return uY;
  }

  int lZ() {
    return lZ;
  }

  int uZ() {
    return uZ;
  }

  static class BinaryGridArray3D extends BinaryGrid3D {
    boolean[] grid;
    int sizeYZ;

    BinaryGridArray3D(final PVector c, final int sizeX, final float dX, final int sizeY, final float dY,
        final int sizeZ, final float dZ) {
      this.sizeX = sizeX;
      this.sizeY = sizeY;
      this.sizeZ = sizeZ;
      this.sizeYZ = sizeZ * sizeY;
      this.dX = dX;
      this.dY = dY;
      this.dZ = dZ;
      center = c.copy();
      grid = new boolean[sizeYZ * sizeX];
      clearLimits();
      min=PVector.sub(center, new PVector(sizeX * 0.5 * dX, sizeY * 0.5 * dY, sizeZ * 0.5 * dZ));
    }


    BinaryGridArray3D(final PVector c, final int sizeX, final float dX, final int sizeY, final float dY,
        final int sizeZ, final float dZ, final boolean[] grid) {
      this.sizeX = sizeX;
      this.sizeY = sizeY;
      this.sizeZ = sizeZ;
      this.sizeYZ = sizeZ * sizeY;
      this.dX = dX;
      this.dY = dY;
      this.dZ = dZ;
      center =  c.copy();
      this.grid = grid;
      clearLimits();
      min=PVector.sub(center, new PVector(sizeX * 0.5 * dX, sizeY * 0.5 * dY, sizeZ * 0.5 * dZ));
    }

    void set(final int x, final int y, final int z) {
      if (x > -1 && y > -1 && z > -1 && x < sizeX && y < sizeY && z < sizeZ) {
        grid[index(x, y, z)] = true;
      }
    }

    void clear(final int x, final int y, final int z) {
      if (x > -1 && y > -1 && z > -1 && x < sizeX && y < sizeY && z < sizeZ) {
        grid[index(x, y, z)] = false;
      }
    }

    boolean getInternal(final int x, final int y, final int z) {
      return grid[index(x, y, z)];
    }

    int index(final int i, final int j, final int k) {
      return k + j * sizeZ + i * sizeYZ;
    }
  }
}
