// array + loop

int num[] = {3,8,14,45,3,88,56,90,13,15,41,53,77,86,49,33};

void settings() {
  size(800, 300);
}

void setup() {
  //
}

void draw() {
  background(#333333);
  stroke(#f7e1c1);
  fill(#d95f59);
  for (int i = 0; i<num.length; i++){
    int multiplier = 2;
    float rw = width / num.length;
    float ypos = height - (num[i] * multiplier);
    rect((rw*i), ypos, rw, (num[i] * multiplier));

  }
}
