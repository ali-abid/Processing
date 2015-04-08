// PROCESSING .pde
// Combine accelerometer and gyro data and draw
// Version 1.0 (April, 2015).
// Abid Ali,
// IMaR Technology Gateway, Institute of Technology Tralee

Table table;
float[] X_ACC_DATA;
float[] Y_ACC_DATA;
float[] Z_ACC_DATA;

float[] X_GYR_DATA;
float[] Y_GYR_DATA;
float[] Z_GYR_DATA;

float[] X_FILL_DATA;
float[] Y_FILL_DATA;
float[] Z_FILL_DATA;



//Task: Read 9 inputs from text file. These inputs are computed in VPython and saved into text file.
float   dt;
float   x_gyr;  //Gyroscope data
float   y_gyr;
float   z_gyr;
float   x_acc;  //Accelerometer data
float   y_acc;
float   z_acc;
float   x_fil;  //Filtered data
float   y_fil;
float   z_fil;

void setup() { 
  //  size(640, 360, P3D); 
  size(1400, 800, P3D);
  noStroke();
  colorMode(RGB, 256); 

  table = loadTable("vpythonOutput.csv", "header");
  println("Total number of lines are in file: ", table.getRowCount());

  // Set range of Arrays length
  X_ACC_DATA = new float[table.getRowCount()];
  Y_ACC_DATA = new float[table.getRowCount()];
  Z_ACC_DATA = new float[table.getRowCount()];

  X_GYR_DATA = new float[table.getRowCount()];
  Y_GYR_DATA = new float[table.getRowCount()];
  Z_GYR_DATA = new float[table.getRowCount()];

  X_FILL_DATA = new float[table.getRowCount()];
  Y_FILL_DATA = new float[table.getRowCount()];
  Z_FILL_DATA = new float[table.getRowCount()];


  for (int i = 0; i < table.getRowCount (); i++)
  {

    X_ACC_DATA[i] = table.getFloat(i, "x");
    Y_ACC_DATA[i] = table.getFloat(i, "y");
    Z_ACC_DATA[i] = table.getFloat(i, "z"); 
    //println("Array "+ i+ " store : X_ACC_DATA[" + X_ACC_DATA[i]+"]" +" Y_ACC_DATA[" + Y_ACC_DATA[i]+"]" + " Z_ACC_DATA[" + Z_ACC_DATA[i]+"]");

    X_GYR_DATA[i] = table.getFloat(i, "Gx");
    Y_GYR_DATA[i] = table.getFloat(i, "Gy");
    Z_GYR_DATA[i] = table.getFloat(i, "Gz");
    //println("Array "+ i+ " store : X_GYR_DATA[" + X_GYR_DATA[i]+"]" +" Y_GYR_DATA[" + Y_GYR_DATA[i]+"]" + " Z_GYR_DATA[" + Z_GYR_DATA[i]+"]");

    X_FILL_DATA[i] = table.getFloat(i, "Fx");
    Y_FILL_DATA[i] = table.getFloat(i, "Fy");
    Z_FILL_DATA[i] = table.getFloat(i, "Fz");
    println("Array "+ i+ " store : X_FILL_DATA[" + X_FILL_DATA[i]+"]" +" Y_FILL_DATA[" + Y_FILL_DATA[i]+"]" + " Z_FILL_DATA[" + Z_FILL_DATA[i]+"]");
  }
} 

