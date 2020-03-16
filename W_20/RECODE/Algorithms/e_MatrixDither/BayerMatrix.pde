/**
 * Dither Class that computes Bayer Matrix dithering algorithm
 *
 * The Bayer Matrix algorithm produces very distinctive
 * cross-hatch patterns.
 */


public class MatrixDither {
  PImage theDImage;
  PImage src;
  int w, h;
  String DType = "BAYER MATRIX";


  public MatrixDither(PImage _src) {
    this.src = _src;
    theDImage = createImage(src.width, src.height, RGB);
    w = src.width;
    h = src.height;
  }


  public void computeMatrixDither(float _v, String _type) {
    this.DType = "Matrix_"+_type;

    if (_type.equals("2X2")) {
      float[] d = {2, 3, 4, 1};

      if (_v>0)gammaCorrection(_v);

      for (int i=0; i<d.length; i++) {
        d[i]=d[i] * 64 - 1;

        for (int y=0; y<src.height; y++) {
          for (int x=0; x<src.width; x++) {
            color oldpixel = src.get(x, y);
            color value = color( brightness(oldpixel) + d[(y%2*2+x%2)]);
            color newpixel = findClosestColor(value);
            src.set(x, y, newpixel);
            theDImage.set(x, y, newpixel);
          }
        }
      }
    } else if (_type.equals("4X4")) {
      float[] d = {0.1250, 1.0000, 0.1875, 0.8125, 0.6250, 0.3750, 0.6875,
        0.4375, 0.2500, 0.8750, 0.0625, 0.9375, 0.7500, 0.5000, 0.5625, 0.3125};

      if (_v>0)gammaCorrection(_v);

      for (int i=0; i<d.length; i++)
        d[i]*=255;

      for (int y=0; y<src.height; y++) {
        for (int x=0; x<src.width; x++) {
          color oldpixel = src.get(x, y);
          color value = color( brightness(oldpixel) + d[(y%4*4+x%4)]);
          color newpixel = findClosestColor(value);
          src.set(x, y, newpixel);
          theDImage.set(x, y, newpixel);
        }
      }
    } else if (_type.equals("8X8")) {
      int[] d = {1, 33, 9, 41, 3, 35, 11, 43, 49, 17, 57, 25, 51, 19, 59, 27, 13, 45, 5,
        37, 15, 47, 7, 39, 61, 29, 53, 21, 63, 31, 55, 23, 4, 36, 12, 44, 2, 34, 10, 42, 52,
        20, 60, 28, 50, 18, 58, 26, 16, 48, 8, 40, 14, 46, 6, 38, 64, 32, 56, 24, 62, 30,
        54, 22};

      if (_v>0)gammaCorrection(_v);

      for (int i=0; i<d.length; i++)
        d[i]=d[i] * 4 - 1;

      for (int y=0; y<src.height; y++) {
        for (int x=0; x<src.width; x++) {
          color oldpixel = src.get(x, y);
          color value = color( brightness(oldpixel) + d[(y%8*8+x%8)]);
          color newpixel = findClosestColor(value);
          src.set(x, y, newpixel);
          theDImage.set(x, y, newpixel);
        }
      }
    } else if (_type.equals("4XCluster")) {
      float[] d = {0.7500, 0.3750, 0.6250, 0.2500, 0.0625, 1.0000, 0.8750, 0.4375,
        0.5000, 0.8125, 0.9375, 0.1250, 0.1875, 0.5625, 0.3125, 0.6875};

      if (_v>0)gammaCorrection(_v);

      for (int i=0; i<d.length; i++)
        d[i]*=255;

      for (int y=0; y<src.height; y++) {
        for (int x=0; x<src.width; x++) {
          color oldpixel = src.get(x, y);
          color value = color( brightness(oldpixel) + d[(y%4*4+x%4)]);
          color newpixel = findClosestColor(value);
          src.set(x, y, newpixel);
          theDImage.set(x, y, newpixel);
        }
      }
    }
  }


  public void drawImage() {
    loadPixels();
    for (int i = 0; i < theDImage.pixels.length; i++) {
      pixels[i] = theDImage.pixels[i];
    }
    updatePixels();
  }



  public color findClosestColor(color c) {
    color r;
    if (brightness(c) < 128) {
      r = color(0);
    } else {
      r = color(255);
    }
    return r;
  }


  // good for fine-tuning images for contrast
  public void gammaCorrection(float _gval) {
    src.loadPixels();
    float tempFloat;
    float GammaValue = _gval;  // Normally in the range 0.25 - 4.0
    for (int i = 0; i < src.pixels.length; i++) {
      tempFloat = brightness(src.pixels[i])/255;
      src.pixels[i] = color(floor(255 * pow(tempFloat, GammaValue)));
    }
    src.updatePixels();
  }
}
