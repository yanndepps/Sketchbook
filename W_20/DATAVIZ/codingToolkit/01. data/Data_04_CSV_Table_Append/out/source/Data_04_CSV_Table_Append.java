import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Data_04_CSV_Table_Append extends PApplet {


Table table;
String month[] = new String[0];
float walk[] = new float[0];
float run[] = new float[0];
float cycle[] = new float[0];

public void setup() {
  table = loadTable("Activities.csv", "header");
  for (TableRow row : table.rows()) {
    month = append(month, row.getString("Month"));
    walk = append(walk, row.getFloat("Walk"));
    run = append(run, row.getFloat("Run"));
    cycle = append(cycle, row.getFloat("Cycle"));
    println(month[month.length-1] + ": " + walk[walk.length-1] + ", " + run[run.length-1] + ", "  + cycle[cycle.length-1]);
  }
}

public void draw() {
  background(33, 33, 33, 100);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Data_04_CSV_Table_Append" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
