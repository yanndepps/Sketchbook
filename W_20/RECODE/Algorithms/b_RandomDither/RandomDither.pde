/**
 * Dither Class that computes random dithering algorithm
 *
 * For each dot in our grayscale image, we generate
 * a random number in the range 0 - 255: if the random number is greater
 * than the image value at that dot, the display device plots the dot white;
 * otherwise, it plots it black.
 */


public class RandDither {
  PImage theDImage;
  PImage src;
  int w, h;


  public RandDither(PImage _src) {
    this.src = _src;
    theDImage = createImage(src.width, src.height, RGB);
    w = src.width;
    h = src.height;
  }


  public void computeRandDither(float _v, int _mode) {
    int s = 1;
    if(_v>0)gammaCorrection(_v);
    int fact = 0;
    if(_mode == 1) fact = 4;
    if(_mode == 2) fact = 8;
    if(_mode == 3) fact = 12;
    if(_mode == 4) fact = 16;
    if(_mode == 5) fact = 24;
    for (int x = 0; x < src.width; x+=s) {
      for (int y = 0; y < src.height; y+=s) {
        color oldpixel = src.get(x, y);
        color newpixel = findClosestRandColor(oldpixel);
        if(_mode != 0) {
          float quant_error = brightness(oldpixel) - brightness(newpixel);
          src.set(x, y, newpixel);

          src.set(x+s, y, color(brightness(src.get(x+s, y)) + 7.0/fact * quant_error) );
          src.set(x-s, y+s, color(brightness(src.get(x-s, y+s)) + 3.0/fact * quant_error) );
          src.set(x, y+s, color(brightness(src.get(x, y+s)) + 5.0/fact * quant_error) );
          src.set(x+s, y+s, color(brightness(src.get(x+s, y+s)) + 1.0/fact * quant_error));
        }
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

  color findClosestRandColor(color c) {
    color r;
    int rand = (int)random(256);
    if (brightness(c) < rand) {
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
