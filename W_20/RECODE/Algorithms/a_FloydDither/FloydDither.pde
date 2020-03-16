/**
 * Dither Class that computes Floyd-Steinberg algorithm
 * REF : https://en.wikipedia.org/wiki/Floyd%E2%80%93Steinberg_dithering
 */


public class FloydDither {
  PImage theDImage;
  PImage src;
  int w, h;


  public FloydDither(PImage _src) {
    this.src = _src;
    theDImage = createImage(src.width, src.height, RGB);
    w = src.width;
    h = src.height;
  }


  public void computeFloydDither(float _v) {
    int s = 1;
    gammaCorrection(_v);
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