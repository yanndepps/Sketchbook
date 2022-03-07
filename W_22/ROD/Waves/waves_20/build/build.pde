/*
 * dynamic waveforms with nested for-loops
 * variation #07
 * perfect loop
 * we used radians() to drive the frameCount in the sin(), cos() and tan() functions.
 * The reason for this is that this way one know exactly when the wave reaches its
 * starting point again, namely in frame 360.
 * One cycle of the wave is exactly 360 frames long.
 * When one renders videos and animation from sketches and use wave movements in them,
 * one ends the rendering at frame 359, because frame 360 is the same as frame 0.
 * When the video is then looped, it creates the illusion that it is infinitely
 * long and has no end.
 */

float r;

void setup() {
  size(640, 640);
  frameRate(30);
  noStroke();
  fill(#f4f4f4);
  r = 1.5;
}

void draw () {
  background(0);
  // ---
  float tiles_x = 16 * 6;
  float tiles_y = 16 * 6;
  float tile_w = width / tiles_x;
  float tile_h = height / tiles_y;
  float offset = 2.0;
  float mult_x = 1.0;
  float mult_y = 2.0;
  float mag = floor( tile_w * ( 3 * 15 ) );
  // println("mag -> ", mag);
  // ---
  translate(tile_w / 2, tile_h / 2);
  // ---
  for (int x = 0; x < tiles_x; x++) {
    for (int y = 0; y < tiles_y; y++) {
      float wave_x = sin(radians(frameCount * offset + x * mult_x + y * 2)) * mag;
      float wave_y = sin(radians(frameCount * offset + x * mult_y + y * 1)) * ( mag * 0.4 );
      // ---
      pushMatrix();
      translate(tile_w * x + wave_x, tile_h * y + wave_y);
      // ellipse(0, 0, tile_w / 4, tile_h / 4);
      ellipse(0, 0, r*2, r*2);
      popMatrix();
    }
  }
}
