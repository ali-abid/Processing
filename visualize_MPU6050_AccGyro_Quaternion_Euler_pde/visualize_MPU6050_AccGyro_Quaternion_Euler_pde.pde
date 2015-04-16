// PROCESSING .pde
// Visualize filtered accelerometer and gyroscope data using quaternion and eular formulas.
// Version 1.0 (April, 2015).
// Abid Ali,
// IMaR Technology Gateway, Institute of Technology Tralee

//DECLARE ARRAYS
float[] X_FILL_DATA;
float[] Y_FILL_DATA;
float[] Z_FILL_DATA;
float[] ANGLE;
float [] q = new float [4];
float [] hq = null;
float [] Euler = new float [3]; // psi, theta, phi

//DECLARE VARIABLES
int qnum = 0;
//READ FILE USING TABLE
Table table;

//FONT
PFont font;

//WINDOW SIZE
final int VIEW_SIZE_X = 1000, VIEW_SIZE_Y = 1000;


void setup() {
  size(VIEW_SIZE_X, VIEW_SIZE_Y, P3D);
  textureMode(NORMAL);
  fill(255);
  stroke(color(44, 48, 32));

  //READ FILE DATA USING TABLE 
  table = loadTable("vpythonOutput.csv", "header");
  println("Total number of lines are in file: ", table.getRowCount());

  //THIS FONT IS LOCATED IN DATA DIRECTORY 
  font = loadFont("CourierNew36.vlw");
}

