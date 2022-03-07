/*
 * waves combination 02
 */

int upsetter = 2;
float radius = 1.5;
int mul = 100;
float waveOffset_1 = 1.45;
float waveOffset_2 = 1.3;

void setup() {
  size(640, 640);
  background(0);
  fill(#f4f4f4);
  noStroke();
}

void draw () {
  translate(width/2, height/2);
  for (int i = 0; i < mul; i++) {
    float wave_x1 = sin(radians(frameCount * waveOffset_1 + i)) * width * 0.3;
    float wave_x2 = sin(radians(frameCount * upsetter + i * 5)) * width * 0.1;
    float wave_y1 = cos(radians(frameCount * waveOffset_2 + i)) * height * 0.4;

    ellipse(wave_x1 + wave_x2, wave_y1, radius*2, radius*2);
  }
}
