/*
A simple sketch to show how to access the individual colors generated by the Squirrel app.

1) Copy and paste the colors from the TXT file generated from the Squirrel app
2) Draw cycles through the palette array
 */

int[] palette = {color(199.0, 169.0, 141.0), color(126.0, 106.0, 83.0), color(129.0, 120.0, 103.0), color(123.0, 73.0, 62.0), color(123.0, 80.0, 68.0), color(121.0, 82.0, 70.0), color(218.0, 200.0, 185.0), color(216.0, 197.0, 175.0), color(136.0, 122.0, 92.0), color(177.0, 208.0, 192.0), color(162.0, 196.0, 178.0), color(106.0, 126.0, 117.0), color(108.0, 127.0, 121.0), color(106.0, 126.0, 117.0), color(34.0, 33.0, 43.0), color(33.0, 34.0, 44.0), color(183.0, 210.0, 197.0), color(53.0, 54.0, 59.0), color(59.0, 59.0, 60.0), color(205.0, 235.0, 208.0), color(56.0, 59.0, 59.0), color(33.0, 33.0, 42.0), color(98.0, 111.0, 100.0), color(32.0, 32.0, 41.0), color(32.0, 33.0, 41.0), color(106.0, 124.0, 118.0), color(58.0, 64.0, 62.0), color(67.0, 72.0, 68.0), color(188.0, 210.0, 198.0), color(186.0, 211.0, 199.0), color(190.0, 211.0, 200.0), color(30.0, 29.0, 41.0), color(103.0, 123.0, 112.0), color(108.0, 124.0, 117.0), color(108.0, 124.0, 118.0), color(121.0, 135.0, 131.0), color(185.0, 219.0, 199.0), color(44.0, 44.0, 49.0), color(42.0, 44.0, 47.0), color(192.0, 216.0, 201.0), color(48.0, 48.0, 49.0), color(29.0, 29.0, 41.0), color(113.0, 128.0, 117.0), color(29.0, 30.0, 41.0), color(29.0, 29.0, 41.0), color(39.0, 49.0, 47.0), color(64.0, 73.0, 70.0), color(53.0, 59.0, 54.0), color(111.0, 129.0, 109.0), color(188.0, 213.0, 201.0), color(188.0, 211.0, 199.0), color(111.0, 127.0, 121.0), color(110.0, 127.0, 121.0), color(113.0, 127.0, 122.0), color(138.0, 127.0, 122.0), color(135.0, 85.0, 74.0), color(235.0, 203.0, 183.0), color(227.0, 205.0, 188.0), color(225.0, 204.0, 185.0), color(225.0, 203.0, 187.0), color(226.0, 203.0, 185.0), color(129.0, 111.0, 99.0), color(126.0, 106.0, 83.0), color(120.0, 99.0, 75.0), color(130.0, 111.0, 92.0), color(129.0, 113.0, 94.0), color(215.0, 188.0, 160.0), color(206.0, 182.0, 150.0), color(226.0, 200.0, 171.0), color(216.0, 190.0, 161.0)};
int id  = 0;

void setup() {
  size(900, 600);
  
  // Slow it down to reduce the strobe effect
  frameRate(4);
}

void draw() {
  background(palette[id]);

  // Cycle through the colors
  if (id >= palette.length-1) {
    id = 0;
  } else {
    id++;
  }
  println(id+" out of "+palette.length);
}