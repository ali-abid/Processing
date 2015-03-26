// PROCESSING .pde
// Combine accelerometer and gyro data and draw
// Version 1.0 (March, 2015).
// Abid Ali,
// IMaR Gateway Technology, Institute of Technology Tralee

Table table;

void setup() {
  table = loadTable("1round.csv", "header");
  println(table.getRowCount() + " total rows in table");
  for (TableRow row : table.rows()) {
    
    String x = row.getString("x");
    String y = row.getString("y");
    String z    = row.getString("z");
    
    println("x:" +x+ "y:" +y+ "z:" +z);
  }
}


