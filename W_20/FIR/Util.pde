import java.util.Collections;

public static boolean isPartOfInterval(int value, int min, int max)
{
  return((value > min-1) && (value < max+1));
}

float midPoint(float a, float b) {
  float x;
  x = (a+b)/2;
  return x;
}
