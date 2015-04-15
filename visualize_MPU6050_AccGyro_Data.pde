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