// PROCESSING .pde
// Combine accelerometer and gyro data and draw
// Version 1.0 (April, 2015).
// Abid Ali,
// IMaR Technology Gateway, Institute of Technology Tralee



long lastTime = 0;
int qnum = 0;
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
float[] ANGLE;

float [] q = new float [4];
float [] hq = null;
float [] Euler = new float [3]; // psi, theta, phi

PFont font;
//final int VIEW_SIZE_X = 1024, VIEW_SIZE_Y = 768;
final int VIEW_SIZE_X = 1000, VIEW_SIZE_Y = 1000;

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

PImage topside, downside, frontside, rightside;

void setup() {
  size(VIEW_SIZE_X, VIEW_SIZE_Y, P3D);
  textureMode(NORMAL);
  fill(255);
  stroke(color(44, 48, 32));


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

  ANGLE = new float[table.getRowCount()];
  for (int i = 0; i < table.getRowCount (); i++)
  {

    //X_ACC_DATA[i] = table.getFloat(i, "FillX");
    //Y_ACC_DATA[i] = table.getFloat(i, "FillY");
    //Z_ACC_DATA[i] = table.getFloat(i, "FillZ"); 
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

  // The font must be located in the sketch's "data" directory to load successfully
  font = loadFont("CourierNew36.vlw"); 
  // Loading the textures to the cube
  // The png files alow to put the board holes so can increase  realism 
  topside = loadImage("MPU6050_A.png");//Top Side
  downside = loadImage("MPU6050_B.png");//Botm side
  frontside = loadImage("MPU6050_E.png"); //Wide side
  rightside = loadImage("MPU6050_F.png");// Narrow side
  delay(100);
} 

float [] readQ(int i) {
  ANGLE[i] = atan2(Y_FILL_DATA[i], X_FILL_DATA[i]);
  //println(ANGLE[i]);
  q[0] = cos(ANGLE[i]/2);
  q[1] = X_FILL_DATA[i] * sin(ANGLE[i]/2);
  q[2] = Y_FILL_DATA[i] * sin(ANGLE[i]/2);
  q[3] = Z_FILL_DATA[i] * sin(ANGLE[i]/2);
  //println(q);
  return q;
}
void topboard(PImage imag) {
  beginShape(QUADS);
  texture(imag);
  // -Y "top" face
  vertex(-20, -1, -15, 0, 0);
  vertex( 20, -1, -15, 1, 0);
  vertex( 20, -1, 15, 1, 1);
  vertex(-20, -1, 15, 0, 1);

  endShape();
}

void botomboard(PImage imag) {
  beginShape(QUADS);
  texture(imag);

  // +Y "bottom" face
  vertex(-20, 1, 15, 0, 0);
  vertex( 20, 1, 15, 1, 0);
  vertex( 20, 1, -15, 1, 1);
  vertex(-20, 1, -15, 0, 1);

  endShape();
}


void sideboarda(PImage imag) {
  beginShape(QUADS);
  texture(imag);

  // +Z "front" face
  vertex(-20, -1, 15, 0, 0);
  vertex( 20, -1, 15, 1, 0);
  vertex( 20, 1, 15, 1, 1);
  vertex(-20, 1, 15, 0, 1);

  // -Z "back" face
  vertex( 20, -1, -15, 0, 0);
  vertex(-20, -1, -15, 1, 0);
  vertex(-20, 1, -15, 1, 1);
  vertex( 20, 1, -15, 0, 1);


  endShape();
}

void sideboardb(PImage imag) {
  beginShape(QUADS);
  texture(imag);

  // +X "right" face
  vertex( 20, -1, 15, 0, 0);
  vertex( 20, -1, -15, 1, 0);
  vertex( 20, 1, -15, 1, 1);
  vertex( 20, 1, 15, 0, 1);

  // -X "left" face
  vertex(-20, -1, -15, 0, 0);
  vertex(-20, -1, 15, 1, 0);
  vertex(-20, 1, 15, 1, 1);
  vertex(-20, 1, -15, 0, 1);

  endShape();
}




void drawCube() {
  pushMatrix();
  translate(VIEW_SIZE_X/2, VIEW_SIZE_Y/2 + 50, 0);
  //scale(5,5,5);
  scale(10);

  // a demonstration of the following is at 
  // http://www.varesano.net/blog/fabio/ahrs-sensor-fusion-orientation-filter-3d-graphical-rotating-cube
  rotateZ(-Euler[2]);
  rotateX(-Euler[1]);
  rotateY(-Euler[0]);


  topboard(topside);
  botomboard(downside);
  sideboarda(frontside);
  sideboardb(rightside);


  popMatrix();
}

void draw() {
  background(#000000);
  //lights();
  if (qnum < X_FILL_DATA.length) {
    q =  readQ(qnum);
    quaternionToEuler(q, Euler);
    text("LD Golf and IMaR Technology Gateway ", 20, VIEW_SIZE_Y - 30);

    textFont(font, 20);
    textAlign(LEFT, TOP);
    text("Q:\n" + q[0] + "\n" + q[1] + "\n" + q[2] + "\n" + q[3], 20, 20);
    text("Euler Angles:\nYaw (psi)  : " + degrees(Euler[0]) + "\nPitch (theta): " + degrees(Euler[1]) + "\nRoll (phi)  : " + degrees(Euler[2]), 200, 20);
    drawCube();
    delay(100);
    qnum++;
  } else {
    noLoop();
    println("File End");
    qnum = 0;
  }
  //delay(100);
  drawCube();
 
}

// See Sebastian O.H. Madwick report 
// "An efficient orientation filter for inertial and intertial/magnetic sensor arrays" Chapter 2 Quaternion representation

void quaternionToEuler(float [] q, float [] euler) {
  euler[0] = atan2(2 * q[1] * q[2] - 2 * q[0] * q[3], 2 * q[0]*q[0] + 2 * q[1] * q[1] - 1); // psi
  println("q0",q[0], "q1:", q[1], "q2: ",q[2], "q3",q[3]);
  //euler[1] = asin(2 * q[1] * q[3] + 2 * q[0] * q[2]); // theta
  euler[1] = 0.6;
  println(euler[1]);
  euler[2] = atan2(2 * q[2] * q[3] - 2 * q[0] * q[1], 2 * q[0] * q[0] + 2 * q[3] * q[3] - 1); // phi
}




