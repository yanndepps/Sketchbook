// Coding Challenge #127 : Brownian Tree Snowflake
// Part 02 : RunwayML outputs

Particle current;
ArrayList<Particle> snowflake;

void setup() {
  size(512, 512);
  // fullScreen();
  resetSnowFlake();
}

void resetSnowFlake() {
  current = new Particle(width/2, 0);
  snowflake = new ArrayList<Particle>();
}

void draw() {
  boolean finished = false;
  while (!finished) {
    int count = 0;
    while (!current.finished() && !current.intersects(snowflake)) {
      current.update();
      count++;
    }

    snowflake.add(current);
    current = new Particle(width/2, 0);

    if (count == 0) {
      finished = true;
    }
  }

  translate(width/2, height/2);
  rotate(random(TWO_PI));
  background(0);
  colorMode(HSB, 256);
  float rHue = random(255);
  color col = color(rHue, 255, 255);

  for (int i = 0; i < 6; i++) {
    rotate(PI/3);
    current.show(col);
    for (Particle p : snowflake) {
      p.show(col);
    }

    pushMatrix();
    scale(1, -1);
    current.show(col);
    for (Particle p : snowflake) {
      p.show(col);
    }
    popMatrix();
  }
  resetSnowFlake();
  saveFrame("snowflakes/snowflake####.png");
}
