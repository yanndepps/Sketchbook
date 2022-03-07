/*
 * complex waveforms
 */

int upsetter = 8;
int radius = 1;
int mul = 20;
float waveOffset_1 = 1.0;
float waveOffset_2 = 0.25;

void setup() {
  size(640, 640);
  background(0);
  fill(#f4f4f4f4);
  noStroke();
}

void draw () {
  translate(width/2, height/2);
  for (int i = 0; i < mul; i++) {
    float wave_x1 = sin(radians(frameCount * waveOffset_1)) * height * 0.4;
    float wave_x2 = sin(radians(frameCount * upsetter + i)) * 40;

    float wave_y1 = cos(radians(frameCount * waveOffset_2)) * height * 0.4;
    float wave_y2 = cos(radians(frameCount * upsetter + i)) * 40;
    ellipse(wave_x1 + wave_x2, wave_y1 + wave_y2, radius*2, radius*2);
  }
}
