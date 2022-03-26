/*
 * FVS
 * draw the number "9" on a 9-module grid.
 * step_02
 */

color bg = color(0, 15, 33);
color from = #ED0DD9; // tendinous fuchsia
color to = #C1C6FC; // isotopic light perwinkle
// ---
float tiles_x, tiles_y;
float tile_w, tile_h;

void setup() {
  size(512, 512, P2D);
  // ---
  tiles_x = tiles_y = 3;
  tile_w = floor( width / tiles_x );
  tile_h = floor( height / tiles_y );
  // ---
  // println("tile width -> ", tile_w);
  noLoop();
}

void draw() {
  background(bg);
  noStroke();
  // grid system
  for (int x = 0; x < tiles_x; x++) {
    for (int y = 0; y < tiles_y; y++) {
      float pos_x = tile_w * x;
      float pos_y = tile_h * y;
      // ---
      pushMatrix();
      translate(pos_x, pos_y);
      // arc(0, 0, tile_w*2, tile_h*2, radians(0), radians(90));
      // arc(tile_w, 0, tile_w*2, tile_h*2, radians(90), radians(180));
      // arc(tile_w, tile_h, tile_w*2, tile_h*2, radians(180), radians(270));
      // arc(0, tile_h, tile_w*2, tile_h*2, radians(270), radians(360));
      // rect(0, 0, tile_w, tile_h);
      if ( x == 0 && y == 0 ) {
        fill(from);
        arc(tile_w, tile_h, tile_w*2, tile_h*2, radians(180), radians(270));
      } else if ( x == 1 && y == 0 ) {
        fill(to);
        rect(0, 0, tile_w, tile_h);
      } else if ( x == 2 && y == 0 ) {
        fill(from);
        arc(0, tile_h, tile_w*2, tile_h*2, radians(270), radians(360));
      } else if ( x == 0 && y == 1 ) {
        fill(from);
        arc(tile_w, 0, tile_w*2, tile_h*2, radians(90), radians(180));
      } else if ( x == 1 && y == 1 ) {
        fill(to);
        rect(0, 0, tile_w, tile_h);
      } else if ( x == 2 && y == 1 ) {
        fill(to);
        rect(0, 0, tile_w, tile_h);
      } else if ( x == 2 && y == 2 ) {
        fill(from);
        arc(0, 0, tile_w*2, tile_h*2, radians(0), radians(90));
      } else if ( x == 1 && y == 2 ) {
        fill(to);
        rect(0, 0, tile_w, tile_h);
      } else if ( x == 0 && y == 2 ) {
        fill(from);
        arc(tile_w, 0, tile_w*2, tile_h*2, radians(90), radians(180));
      }
      popMatrix();
    }
  }
}
