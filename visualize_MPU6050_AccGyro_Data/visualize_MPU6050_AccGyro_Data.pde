// PROCESSING .pde
// Visualize accelerometer and gyroscope data. 
// Read converted raw data as input and process filter data.
// Version 1.0 (April, 2015).
// Abid Ali,
// IMaR Technology Gateway, Institute of Technology Tralee

//DECLARE ARRAYS
float[] X_ACC_DATA;
float[] Y_ACC_DATA;
float[] Z_ACC_DATA;

float[] X_GYR_DATA;
float[] Y_GYR_DATA;
float[] Z_GYR_DATA;

float[] X_FILL_DATA;
float[] Y_FILL_DATA;
float[] Z_FILL_DATA;

//DECLARE ACC & GYRO VARIABLE NAMES
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

int i = 0;
Table table;

// SET WINDOW SIZE
final int VIEW_SIZE_X = 1400, VIEW_SIZE_Y = 800;


void setup() {
  size(VIEW_SIZE_X, VIEW_SIZE_Y, P3D);
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

  //ANGLE = new float[table.getRowCount()];
  for (int i = 0; i < table.getRowCount (); i++)
  {

    X_ACC_DATA[i] = table.getFloat(i, "x");
    Y_ACC_DATA[i] = table.getFloat(i, "y");
    Z_ACC_DATA[i] = table.getFloat(i, "z"); 
    //println("Array "+ i+ " store : X_ACC_DATA[" + X_ACC_DATA[i]+"]" +" Y_ACC_DATA[" + Y_ACC_DATA[i]+"]" + " Z_ACC_DATA[" + Z_ACC_DATA[i]+"]");

    //X_GYR_DATA[i] = table.getFloat(i, "Gx");
    //Y_GYR_DATA[i] = table.getFloat(i, "Gy");
    //Z_GYR_DATA[i] = table.getFloat(i, "Gz");
    //println("Array "+ i+ " store : X_GYR_DATA[" + X_GYR_DATA[i]+"]" +" Y_GYR_DATA[" + Y_GYR_DATA[i]+"]" + " Z_GYR_DATA[" + Z_GYR_DATA[i]+"]");

    X_FILL_DATA[i] = table.getFloat(i, "FillX");
    Y_FILL_DATA[i] = table.getFloat(i, "FillY");
    Z_FILL_DATA[i] = table.getFloat(i, "FillZ");
    // println("Array "+ i+ " store : X_FILL_DATA[" + X_FILL_DATA[i]+"]" +" Y_FILL_DATA[" + Y_FILL_DATA[i]+"]" + " Z_FILL_DATA[" + Z_FILL_DATA[i]+"]");
  }
}

void readProcessedData(int i) {
  delay(100);
  // Tweak the view of the rectangles
  int distance = 50;
  int x_rotation = 90;
  
  //Show accel data
  pushMatrix();
  translate(width/2, height/2, -50);
  rotateX(radians(-X_ACC_DATA[i] - x_rotation));
  rotateY(radians(-Y_ACC_DATA[i]));
  draw_rect(56, 140, 206);
  popMatrix();
  
  //Show Combined Data
  pushMatrix();
  translate(5*width/6, height/2, -50);
  rotateX(radians(-X_FILL_DATA[i] - x_rotation));
  rotateY(radians(-Y_FILL_DATA[i]));
  draw_rect(93, 175, 83);
  popMatrix();

  textSize(24);
  String accStr = "(" + (int) X_ACC_DATA[i] + ", " + (int) Y_ACC_DATA[i]  + ")";
  String filStr = "(" + (int) X_FILL_DATA[i] + ", " + (int)Y_FILL_DATA[i] + ")";
  
  fill(56, 140, 206);
  text("Accelerometer", (int) width/2.0 - 50, 25);
  text(accStr, (int) (width/2.0) - 30, 50); 
  
  fill(83, 175, 93);
  text("Combination", (int) (5.0*width/6.0) - 40, 25);
  text(filStr, (int) (5.0*width/6.0) - 20, 50);
}

void draw_rect(int r, int g, int b) {
  scale(90);
  beginShape(QUADS);

  fill(r, g, b);
  vertex(-1, 1.5, 0.25);
  vertex( 1, 1.5, 0.25);
  vertex( 1, -1.5, 0.25);
  vertex(-1, -1.5, 0.25);

  vertex( 1, 1.5, 0.25);
  vertex( 1, 1.5, -0.25);
  vertex( 1, -1.5, -0.25);
  vertex( 1, -1.5, 0.25);

  vertex( 1, 1.5, -0.25);
  vertex(-1, 1.5, -0.25);
  vertex(-1, -1.5, -0.25);
  vertex( 1, -1.5, -0.25);

  vertex(-1, 1.5, -0.25);
  vertex(-1, 1.5, 0.25);
  vertex(-1, -1.5, 0.25);
  vertex(-1, -1.5, -0.25);

  vertex(-1, 1.5, -0.25);
  vertex( 1, 1.5, -0.25);
  vertex( 1, 1.5, 0.25);
  vertex(-1, 1.5, 0.25);

  vertex(-1, -1.5, -0.25);
  vertex( 1, -1.5, -0.25);
  vertex( 1, -1.5, 0.25);
  vertex(-1, -1.5, 0.25);

  endShape();
}

void draw() { 

  //Show combined data
  if (i < table.getRowCount ()) {
    background(0);
    lights();
    println("File line number :",i);
    readProcessedData(i);
    i++;
  } else {
    noLoop();
    println("File End");
    i = 0;
  }
} 

