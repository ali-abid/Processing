// PROCESSING .pde
// Combine accelerometer and gyro data and draw
// Version 1.0 (March, 2015).
// Abid Ali,
// IMaR Technology Gateway, Institute of Technology Tralee

Table table;
float[] AX;
float[] AY;
float[] AZ;

void setup() {
  table = loadTable("1round.csv", "header");
  println(table.getRowCount() + " total rows in table");
  // Set range of Arrays length
  AX = new float[table.getRowCount()];
  AY = new float[table.getRowCount()];
  AZ = new float[table.getRowCount()];
  for (int i = 0; i < table.getRowCount (); i++)
  {
    //println(table.getFloat(i,"z"));
    AX[i] = table.getFloat(i, "x");
    AY[i] = table.getFloat(i, "y");
    AZ[i] = table.getFloat(i, "z");
    println("Array "+ i+ "store : AX[" + AX[i]+"]" +"AY[" + AY[i]+"]" + "AZ[" + AZ[i]+"]");
  }
}

