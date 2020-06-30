PVector[] myPoints = new PVector[25];
PVector[] myVels = new PVector[myPoints.length];

void setup()
{
  size(512, 512);
  for (int i = 0; i < myPoints.length; i++)
  {
    myPoints[i] = new PVector(random(width), random(height));
    myVels[i] = new PVector(random(-1, 1), random(-1, 1));
  }
}

void draw()
{
  background(#689894);
  loadPixels();
  for (int i = 0; i < width; i++)
  {
    for (int j = 0; j < height; j++)
    {
      float[] distances = new float[myPoints.length];
      for (int k = 0; k < myPoints.length; k++)
      {
        distances[k] = dist(i, j, myPoints[k].x, myPoints[k].y);
      }
      distances = sort(distances);
      if (distances[2] - distances[1] < 2)
      {
        pixels[i + j * width] = color(0);
      }
    }
  }
  updatePixels();

  for (int i = 0; i < myPoints.length; i++)
  {
    myPoints[i].add(myVels[i]);
    if (myPoints[i].x < 0 || myPoints[i].x > width || myPoints[i].y < 0 || myPoints[i].y > height)
    {
      myVels[i].mult(-1); 
      myPoints[i].add(myVels[i]);
    }
  }

  if (frameCount < 1000)
  {
    saveFrame("images/frame####.png");
  }
}
