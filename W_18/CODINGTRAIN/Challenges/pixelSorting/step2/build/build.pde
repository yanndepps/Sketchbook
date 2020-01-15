/*
* creative coding : pixel sorting by hue
*/


PImage img;
PImage sorted;

void setup() {
	size(1000, 500);
	img = loadImage("dafuck.png");
	sorted = createImage(img.width, img.height, RGB);
	sorted.loadPixels();
	img.loadPixels();
	// for (int i = 0; i < sorted.pixels.length; ++i) {
	// 	sorted.pixels[i] = img.pixels[i];
	// }
	sorted = img.get();
	// selection sort
	for (int i = 0; i < sorted.pixels.length; ++i) {
		// store the record hue of any pixel; no pixel can have a hue less than -1
		float record = -1; 
		int selectedPixel = i;
		for (int j = i; j < sorted.pixels.length; ++j) {
			//the color at that particular pixel
			color pix = sorted.pixels[j];
			//sort by hue, average of the rgb value
			float b = hue(pix);
			if (b > record) {
				selectedPixel = j;
				record = b;
			}
		}

		// once the loop is finished, swap the selected pixel with i
		color temp = sorted.pixels[i];
		sorted.pixels[i] = sorted.pixels[selectedPixel];
		sorted.pixels[selectedPixel] = temp;
	}


	sorted.updatePixels();
}





void draw() {
	background(61);
	image(img, 0, 0);
	image(sorted, 500, 0);
}