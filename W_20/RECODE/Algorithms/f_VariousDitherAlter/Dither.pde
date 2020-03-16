/**
 * Dither Class that computes various algorithms 
 *
 */


class Dither {
  String DType;
  PImage theDImage;
  PImage src;
  int w, h;
  int ditherStep;

  // Bayer matrix for ordered dither
  int[][] matrix = {   
    {
      1, 9, 3, 11
    }
    , 
    {
      13, 5, 15, 7
    }
    , 
    {
      4, 12, 2, 10
    }
    , 
    {
      16, 8, 14, 6
    }
  };
  float mratio = 1.0 / 17;
  float mfactor = 255.0 / 5;


  public Dither(PImage _src, String _DType) {
    this.src = _src;
    theDImage = createImage(src.width, src.height, RGB);
    this.DType = _DType;
    w = src.width;
    h = src.height;
  }

  /**
   * Apply dither according to type
   */
  public void computeDither(float _v, int _step) {
    gammaCorrection(_v);
    this.ditherStep = _step;
    if (DType.equals("FLOYD")) {
      computeFloydDither();
    } else if (DType.equals("ATKINSON")) {
      computeAtkinsonDither();
    } else if (DType.equals("ORDERED")) {
      computeOrderedDither();
    }
  }

  public void computeFloydDither() {
    int s = ditherStep;
    loadPixels();
    for (int x = 0; x < src.width; x+=s) {
      for (int y = 0; y < src.height; y+=s) {
        color oldpixel = src.get(x, y);
        color newpixel = findClosestColor(oldpixel);
        float quant_error = brightness(oldpixel) - brightness(newpixel);
        src.set(x, y, newpixel);

        src.set(x+s, y, color(brightness(src.get(x+s, y)) + 7.0/16 * quant_error) );   
        src.set(x-s, y+s, color(brightness(src.get(x-s, y+s)) + 3.0/16 * quant_error) );
        src.set(x, y+s, color(brightness(src.get(x, y+s)) + 5.0/16 * quant_error) );
        src.set(x+s, y+s, color(brightness(src.get(x+s, y+s)) + 1.0/16 * quant_error));


        // stroke(newpixel);      
        //point(x,y);
        theDImage.set(x, y, newpixel);
      }

      //pixels[y*width+x+s] = color(brightness(src.get(x+s, y)) + 7.0/16 * quant_error);
      updatePixels();
    }
  }

  public void computeOrderedDither() {
    int s = ditherStep;
    for (int x = 0; x < src.width; x+=s) {
      for (int y = 0; y < src.height; y+=s) {
        color oldpixel = src.get(x, y);
        color value = color( brightness(oldpixel) + (mratio*matrix[x%4][y%4] * mfactor));
        color newpixel = findClosestColor(value);

        src.set(x, y, newpixel);
        theDImage.set(x, y, newpixel);
      }
    }
  }

  public void computeAtkinsonDither() {
    int s = ditherStep;

    // Scan image
    for (int x = 0; x < src.width; x+=s) {
      for (int y = 0; y < src.height; y+=s) {
        color oldpixel = src.get(x, y);
        color newpixel = findClosestColor(oldpixel);
        float quant_error = brightness(oldpixel) - brightness(newpixel);
        src.set(x, y, newpixel);

        // Atkinson algorithm http://verlagmartinkoch.at/software/dither/index.html
        src.set(x+s, y, color(brightness(src.get(x+s, y)) + 1.0/8 * quant_error) );
        src.set(x-s, y+s, color(brightness(src.get(x-s, y+s)) + 1.0/8 * quant_error) );
        src.set(x, y+s, color(brightness(src.get(x, y+s)) + 1.0/8 * quant_error) );
        src.set(x+s, y+s, color(brightness(src.get(x+s, y+s)) + 1.0/8 * quant_error));
        src.set(x+2*s, y, color(brightness(src.get(x+2*s, y)) + 1.0/8 * quant_error));
        src.set(x, y+2*s, color(brightness(src.get(x, y+2*s)) + 1.0/8 * quant_error));

        theDImage.set(x, y, newpixel);
      }
    }
  }

  public void drawImage() {
    loadPixels();
    for (int i = 0; i < theDImage.pixels.length; i++) {
      color c = theDImage.pixels[i];
      if(c==color(0)) {
      pixels[i] = theDImage.pixels[i];
      //pixels[i] = color(255, 255, 255);
      }
    }
    updatePixels();
  }

  public void drawImagePDF() {
    noFill();
    for (int x = 0; x < theDImage.width; x+=ditherStep) {
      for (int y = 0; y < theDImage.height; y+=ditherStep) {
        color c = theDImage.get(x, y);
        stroke(c);
        if (c<color(1)) {
          point(x, y);
        }
      }
    }
  }

  color findClosestColor(color c) {
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