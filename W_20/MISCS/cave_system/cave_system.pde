int worldSeed;
float noiseScale;
float cellSize;
float mapWidth;

void setup() {
  size(600, 600);
  mapWidth = 100;
  cellSize = width / mapWidth;
  worldSeed = 0;
  noiseScale = 0.1;
}

void draw() {
  background(0);
  //noiseSeed(worldSeed);
  noStroke();
  for (int j = 0; j < mapWidth; j++) {
    for (int i = 0; i < mapWidth; i++) {
      float h = noise(i * noiseScale, j * noiseScale);
      if (h < 0.40) {
        fill(255);
      } else {
        fill(0);
      }
      rect(i * cellSize, j * cellSize, cellSize, cellSize);
    }
  }
}
