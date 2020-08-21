/* Generate RAW files which can be sonificated and then imported to IrfanView.
 * generateme.tumblr.com, 2015, v0.1.
 * erros? write generateme.blog@gmail.com
 *
 * To use it change lines:
 *    img = loadImage(<insert image filename here>);
 *  and
 *    makeRaw(<filename prefix>, <channel order or gray>, <bits per pixel>, <bits per 1st channel>, <bits per 2nd channel>, <bits per 3rd channel>);
 *
 * Details:
 *   
 * - channel order or gray - 
 *      put here one of the following RGB, RBG, GRB, GBR, BRG, BGR, GRAY - it chooses the order of the channels.
 *      GRAY - sets the same value (luma) for all channels
 *
 * - bits per pixel - 
 *      BPP8 - saves image to RAW with 8bit color. 
 *        for IrfanView call: makeRaw("n",GRAY,BPP8,8,0,0); - experiment with channel order and bits per channel to achive different grayscale posterize effect.
 *      
 *      BPP16_LE_L - saves image to RAW with 16bit color, little endian, pad 0 on the left size of the 16 bit word
 *        In IrfanView:
 *          5:5:5 - this option seems to be buggy;
 *          5:6:5 - call makeRaw("n",RGB,BPP16_LE_L,5,6,5);
 *          5:5:6 - call makeRaw("n",RGB,BPP16_LE_L,6,5,5); - yes it's not a mistake, bug in IV
 *          6:5:5 - call makeRaw("n",RGB,BPP16_LE_L,5,5,6); - yes it's not a mistake, bug in IV
 *  
 *      BPP16_LE_R - 16bit color, little endian, pad 0 on the right side of the 16 bit word
 *      BPP16_BE_L and BPP_BE_R - big endian versions
 *        above can cause lot of glitch, especially when use with different bits per channel
 *  
 *      BPP24 - 24 bit colors
 *        for IrfanView call: makeRaw("n",RGB,BPP24,8,8,8);
 *
 *      BPP32_Ax - 32 bit colors with alpha as a first byte
 *      BPP32_xA - 32 bit colors with alpha as a last byte
 *        for IrfanView call: makeRaw("n",RGB,BPP32_Ax,8,8,8) or makeRaw("n",RGB,BPP32_xA,8,8,8); and choose proper alpha order when importing
 *
 *  (no 10 or 12 bits for now, I have no idea how to pack them) 
 *
 * - bits per channel -
 *  specify how many bits will be used per each channel. From 0 (none) to 8 (all).   
 *
 * Fun begins where you use non standard bits per channel (eg. 277, 385 etc), reorder channels and import into IrfanView.
 * Don't forget to import to Audacity and apply some effect. 
 *
 * NOTE: script is not foolproof, sum of the bits per channel shouldn't be higher than bits per pixel
 * 
 * thx to Letsglitchit (https://www.facebook.com/Letsglitchit) for inspiration
 */ 

import java.io.BufferedOutputStream;
import java.io.DataOutputStream;

PImage img;

void setup() {
  // change image file name
  img = loadImage("n.jpg");
  size(600, 600);
  background(128);
  noStroke();

  // change options here
  makeRaw("n",RGB,BPP32_xA,8,8,8);
}

// do not touch below this line!

static final int RGB = 0;
static final int RBG = 1;
static final int GRB = 2;
static final int GBR = 3;
static final int BRG = 4;
static final int BGR = 5;
static final int GRAY = 6;

static final int BPP8 = 0;
static final int BPP16_LE_L = 1;
static final int BPP16_BE_L = 2;
static final int BPP16_LE_R = 3;
static final int BPP16_BE_R = 4;
static final int BPP24 = 5;
static final int BPP32_Ax = 7;
static final int BPP32_xA = 8;

String order2name(int order) {
  switch(order) {
    case RGB: return "RGB";
    case RBG: return "RBG";
    case GRB: return "GRB";
    case GBR: return "GBR";
    case BRG: return "BRG";
    case BGR: return "BGR";
    case GRAY: return "GRAY";
    default: return "RGB";
  }
}

String bpp2name(int bits) {
  switch(bits) {
    case BPP8: return "8bpp";
    case BPP16_LE_L: return "16bpp_le_l";
    case BPP16_LE_R: return "16bpp_le_r";
    case BPP16_BE_L: return "16bpp_be_l";
    case BPP16_BE_R: return "16bpp_be_r";
    case BPP24: return "24bpp";
    case BPP32_Ax: return "32bpp_ax";
    case BPP32_xA: return "32bpp_xa";
    default: return "none";
  }
}

int extractColor(color c, int no, int bits, int order) {
  float col = 0;
  if(order<6) { // RGB, RBG,...
    switch(no) { //0,1,2
      case 0: {
        if(order < 2) {col = red(c); break;}
        else if(order < 4) {col = green(c); break;}
        else {col = blue(c); break;}
      }
      case 1: {
        if(order==2 || order==4) {col = red(c); break;}
        else if(order == 0 || order == 5) {col = green(c); break;}
        else {col = blue(c); break;}
      }
      default: {
         if(order==3 || order==5) {col = red(c); break;}
        else if(order ==1 || order == 4) {col = green(c); break;}
        else {col = blue(c); break;}
      }
    } 
  } else {
    if(order == GRAY) col = 0.2126 * red(c) + 0.7152 * green(c) + 0.0722 * blue(c);
  }
  
  return (((int)col &0xff) >> (8-bits)) << (8-bits); 
}

int roundcolor(int col, int bits) {
  int iter = 8/bits;
  int newcol = col;
  int newbits = bits;
  while(iter>0) {
    newcol = newcol | (newcol >> newbits);
    newbits += bits;
    iter--;
  }
  return newcol;
}

void makeRaw(String filename_prefix, int order, int bpp, int bits_a, int bits_b, int bits_c) {
  String filename = filename_prefix + "_"+bpp2name(bpp)+"_"+bits_a+bits_b+bits_c+order2name(order)+".raw";
  DataOutputStream out = new DataOutputStream(new BufferedOutputStream(createOutput(filename)));
  
  try {
  for(int y=0;y<height;y++)
  for(int x=0;x<width;x++) {
    color c = img.get(x,y);
    
      int ch1 = extractColor(c,0,bits_a,order);
      int ch2 = extractColor(c,1,bits_b,order);
      int ch3 = extractColor(c,2,bits_c,order);

      if(bpp == BPP8) {
        int col = ch1 | (ch2 >> bits_a) | (ch3 >> (bits_a+bits_b));   
        fill(col);
        out.writeByte(col);
      } else if(bpp == BPP16_LE_L || bpp == BPP16_LE_R || bpp == BPP16_BE_L || bpp == BPP16_BE_R) { 
        fill(roundcolor(ch1,bits_a),roundcolor(ch2,bits_c), roundcolor(ch3,bits_c));
        
        ch1 <<= 8;
        ch2 <<= 8;
        ch3 <<= 8;
        
        int col = ch1 + (ch2 >> bits_a) + (ch3 >> (bits_a+bits_b));
        if(bpp == BPP16_LE_L || bpp == BPP16_BE_L)
          col >>= (16-bits_a-bits_b-bits_c);

        if(bpp == BPP16_LE_L || bpp == BPP16_LE_R) {      
          out.writeByte( col & 0xff );
          out.writeByte( (col & 0xff00) >> 8);
        } else {
          out.writeByte( (col & 0xff00) >> 8);
          out.writeByte( col & 0xff );
        }
       
      } else if(bpp == BPP24) {
        
        ch1 = roundcolor(ch1,bits_a);
        ch2 = roundcolor(ch2,bits_b);
        ch3 = roundcolor(ch3,bits_c);
        
        fill(ch1,ch2,ch3);
        
        out.writeByte(ch1);
        out.writeByte(ch2);
        out.writeByte(ch3);
        
     } else if(bpp == BPP32_Ax || bpp == BPP32_xA) {
        
        ch1 = roundcolor(ch1,bits_a);
        ch2 = roundcolor(ch2,bits_b);
        ch3 = roundcolor(ch3,bits_c);
        int a = int(alpha(c)) & 0xff;
        
        fill(ch1,ch2,ch3,a);
        
        if(bpp == BPP32_Ax) out.writeByte(a);
        out.writeByte(ch1);
        out.writeByte(ch2);
        out.writeByte(ch3);
        if(bpp == BPP32_xA) out.writeByte(a);     
      }
      
    rect(x,y,1,1);
  }
  
  out.flush();
  out.close();
  
  } catch(Exception e) { e.printStackTrace();}
  
}