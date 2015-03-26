// PROCESSING .pde
// Combine accelerometer and gyro data and draw
// Version 1.0 (March, 2015).
// Abid Ali,
// IMaR Gateway Technology, Institute of Technology Tralee

Table table;
float[] AX;
int[] AY;
void setup() {
  table = loadTable("1round.csv", "header");
  println(table.getRowCount() + " total rows in table");
  // Set range of Arrays length
  AX = new float[table.getRowCount()];
  for (int i = 0; i < table.getRowCount (); i++)
  {
    //println(table.getFloat(i,"z"));
    AX[i] = table.getFloat(i, "x");
    println("AX array "+ i+ " store value: " + AX[i]);
  }
}

