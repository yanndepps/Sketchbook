// coding challenge 89 : Langton's Ant --> step1

// --- INIT ---

int[][] grid;
int x;
int y;
int dir;
int ANT_UP = 0;
int ANT_RGT = 1;
int ANT_DWN = 2;
int ANT_LFT = 3;
PImage ant;

void turnRight() {
	dir++;
	if (dir > ANT_LFT) {
		dir = ANT_UP;
	}
}

void turnLeft() {
	dir--;
	if (dir < ANT_UP) {
		dir = ANT_LFT;
	}
}

void moveForward() {
	if (dir == ANT_UP) {
		y--;
	} else if (dir == ANT_RGT) {
		x++;
	} else if (dir == ANT_DWN) {
		y++;
	} else if (dir == ANT_LFT) {
		x--;
	}
	// window edges : right/left
	if (x > width - 1) {
		x = 0;
	} else if (x < 0) {
		x = width-1;
	}
	// up/down
	if (y > height - 1) {
		y = 0;
	} else if (y < 0) {
		y = height-1;
	}
}
// --- SETUP ---

void setup() {
	size(600, 600);
	grid = new int[width][height];
	ant = createImage(width, height, RGB);
	ant.loadPixels();
	for (int i = 0; i < ant.pixels.length; i++) {
		ant.pixels[i] = color(#FFFFFF);
	}
	ant.updatePixels();
	x = width/2;
	y = height/2;
	dir = ANT_UP;
}

void draw() {
	background(#FFFFFF);	
	ant.loadPixels();
	for (int n = 0; n < 500; n++) {
		int state = grid[x][y];
		if (state == 0) {
			turnRight();
			grid[x][y] = 1;
		} else if (state == 1) {
			turnLeft();
			grid[x][y] = 0;
		}
		color col = color(#FFFFFF);
		if (grid[x][y] == 1) {
			col = color(#313437);
		}
		int pix = x + y * ant.width;
		ant.pixels[pix] = col;
		moveForward();
	}
	ant.updatePixels();
	image(ant, 0, 0);
	// replaced by aboce -^
	// loadPixels();
	// for (int i = 0; i < width; i++) {
	// 	for (int j = 0; j < height; j++) {
	// 		// the actual pixel location in the window :
	// 		int pix = i + width * j;
	// 		if (grid[i][j] == 0) {
	// 			pixels[pix] = color(#FFFFFF);
	// 		} else {
	// 			pixels[pix] = color(#313437);
	// 		}
	// 	}
	// }
	// updatePixels();
}

// --- END ---

