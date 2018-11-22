/*
* creative coding : animate the pixel sorting glitches due to misplacing the swap 
*/


PImage img;
PImage sorted;
int index = 0;

void setup() {
	size(1000, 500);
	img = loadImage("b01.jpeg");
	sorted = createImage(img.width, img.height, RGB);
	sorted.loadPixels();
	img.loadPixels();
	sorted = img.get();

}





void draw() {
	background(61);
	println("frameRate: "+frameRate);
 	// selection sort
 	// multiply your computation and save time
 	for (int n = 0; n < 100; ++n) {
	float record = -1; 
	int selectedPixel = index;
	for (int j = index; j < sorted.pixels.length; ++j) {
		//the color at that particular pixel
		color pix = sorted.pixels[j];
		//sort by hue, average of the rgb value
		float b = hue(pix);
		if (b > record) {
			selectedPixel = j;
			record = b;
		}

	// once the loop is finished, swap the selected pixel with index
	color temp = sorted.pixels[index];
	sorted.pixels[index] = sorted.pixels[selectedPixel];
	sorted.pixels[selectedPixel] = temp;
}
	if (index < sorted.pixels.length -1) {
		index++;
	}
}
	sorted.updatePixels();

	image(img, 0, 0);
	image(sorted, 500, 0);
}