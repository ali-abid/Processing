// PROCESSING .pde
// Combine accelerometer and gyro data and draw
// Version 1.0 (April, 2015).
// Abid Ali,
// IMaR Technology Gateway, Institute of Technology Tralee

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

void setup()  { 
//  size(640, 360, P3D); 
  size(1400, 800, P3D);
  noStroke();
  colorMode(RGB, 256); 

} 


