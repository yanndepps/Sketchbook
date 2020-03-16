/**
 * Dither Class that computes Stucki dithering algorithm
 *
 * Similar to Jarvis algorithm but faster.
 * The effect is clean & sharp.
 */


public class StuckiDither {
  PImage theDImage;
  PImage src;
  int w, h;
  String DType = "STUCKI";


  public StuckiDither(PImage _src) {
    this.src = _src;
    theDImage = createImage(src.width, src.height, RGB);
    w = src.width;
    h = src.height;
  }


  public void computeStuckiDither(float _v) {
    float w8= 8.0/42.0;
    float w7=7.0/42.0;
    float w5=5.0/42.0;
    float w4= 4.0/42.0;
    float w2=2.0/42.0;
    float w1=1.0/42.0;
    int s = 1;
    if(_v>0)gammaCorrection(_v);
    for (int y=0; y<src.height; y+=s) {
      for (int x=0; x<src.width; x+=s) {
        color oldpixel = src.get(x, y);
        color newpixel = findClosestColor(oldpixel);
        float quant_error = brightness(oldpixel) - brightness(newpixel);

        src.set(x, y, newpixel);

        src.set(x+1, y, color(brightness(src.get(x+1, y)) + w7 * quant_error));
        src.set(x+2, y, color(brightness(src.get(x+2, y)) + w5 * quant_error));
        src.set(x-2, y+1, color(brightness(src.get(x-2, y+1)) + w2 * quant_error));
        src.set(x-1, y+1, color(brightness(src.get(x-1, y+1)) + w4 * quant_error));
        src.set(x, y+1, color(brightness(src.get(x, y+1)) + w8 * quant_error));
        src.set(x+1, y+1, color(brightness(src.get(x+1, y+1)) + w4 * quant_error));
        src.set(x+2, y+1, color(brightness(src.get(x+2, y+1)) + w2 * quant_error));
        src.set(x-2, y+2, color(brightness(src.get(x-2, y+2)) + w1 * quant_error));
        src.set(x-1, y+2, color(brightness(src.get(x-1, y+2)) + w2 * quant_error));
        src.set(x, y+2, color(brightness(src.get(x, y+2)) + w4 * quant_error));
        src.set(x+1, y+2, color(brightness(src.get(x+1, y+2)) + w2 * quant_error));
        src.set(x+2, y+2, color(brightness(src.get(x+2, y+2)) + w1 * quant_error));
        theDImage.set(x, y, newpixel);
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