/*
 * © thedotisblack
 * ep_30 -> step_01
 * Glowing lines effect with for() and lines
 */

int w = 620;
int h = 620;
int xStep = w/5;
int yStep = h/5;
int xMargin;
int yMargin;

float alpha;
color bg = color(50, 36, 57);
color fg = color(211, 88, 106);

void settings() {
  // size(w, h, P2D);
  fullScreen(P2D);
  smooth();
}

void setup() {
  // surface.setLocation(30, 30);

  xMargin = (width - (floor(width/xStep) * xStep))/2;
  yMargin = (height - (floor(height/yStep) * yStep))/2;
  if (xMargin == 0) xMargin = xStep;
  if (yMargin == 0) yMargin = yStep;
}

void draw() {
  background(bg);

  // x-axis
  float glowRadiusAlpha_x = map(sin(radians(alpha)), -1, 1, -1, 1);
  float glowRadius_x = xStep/2 * glowRadiusAlpha_x;
  for (int x = xMargin; x < width; x += xStep) {
    for (float g = 0; g < glowRadius_x; g++) {
      stroke(fg, 255 * (1 - (g / glowRadius_x)));
      line(x+g, 0, x+g, height);
      line(x-g, 0, x-g, height);
    }
  }

  // y-axis
  float glowRadiusAlpha_y = map(cos(radians(alpha+90)), -1, 1, -1, 1);
  float glowRadius_y = yStep/2 * glowRadiusAlpha_y;
  for (int y = yMargin; y < width; y += yStep) {
    for (float g = 0; g < glowRadius_y; g++) {
      stroke(fg, 255 * (1 - (g / glowRadius_y)));
      line(0, y+g, width, y+g);
      line(0, y-g, width, y-g);
    }
  }
  alpha += 2;
}
