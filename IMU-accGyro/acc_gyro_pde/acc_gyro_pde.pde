// PROCESSING .pde
// Combine accelerometer and gyro data and draw
// Version 1.0 (March, 2015).
// Abid Ali,
// IMaR Technology Gateway, Institute of Technology Tralee

//Task: Following Arduino code converted into Processing, Now next task will be, using the following algorithm for accelerometer and 
// gyro combination data.
// Input of this algorithm will be .csv file parameter time , X Y Z  GY GX  and output would be expected well filtered Acc_Gyro combication
//data.


Table table;
float[] AX;
float[] AY;
float[] AZ;

int INPUT_ACC = 3;
float PI = 3.14159265358979f;
float VDD = 5000.0f;



float[] an = new float[INPUT_ACC]; // number of accelerometer coordinates
int[] zeroLevel = new int[5];  // 0..2 accelerometer zero level (mV) @ 0 G
int[] inpSens = new int[5];    // 0..2 acceleromter input sensitivity (mv/g)
char[] inpInvert = new char[5]; // bits 0..5 invert input
float wGyro;

int firstSample; // marks first sample;


static class struct {
  //char[] inpInvert = new char[5];
  //int[] zeroLevel = new int[5];
  //int[] inSens = new int[5];
  // float wGyro;
} 

float[] RwEst = new float[3];
long lastMicros;
long interval;
float[] RwAcc = new float[3];
float[] RwGyro = new float[3];
float[] Awz = new float[3];




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
    println("Array "+ i+ " store : AX[" + AX[i]+"]" +" AY[" + AY[i]+"]" + " AZ[" + AZ[i]+"]");
  }


  float wGyro;                    // gyro weight/smooting factor

  //Setup parameters for Acc_Gyro board, see http://www.gadgetgangster.com/213
  for (int i = 0; i <=2; i++) { // X,Y,Z axis
    zeroLevel[i] = 1650;        // Accelerometer zero level (mV) @ 0 G
    inpSens[i] = 478;           // Accelerometer Sensisitivity mV/g
  }
  for (int i=3; i<=4; i++) {
    inpSens[i] = 2000;        // Gyro Sensitivity mV/deg/ms    
    zeroLevel[i] = 1230;      // Gyro Zero Level (mV) @ 0 deg/s
  }

  inpInvert[0] = 1;  //Acc X
  inpInvert[1] = 1;  //Acc Y
  inpInvert[2] = 1;  //Acc Z

  //Gyro readings are sometimes inverted according to accelerometer coordonate system
  //see http://starlino.com/imu_guide.html for discussion
  //also see http://www.gadgetgangster.com/213 for graphical diagrams
  inpInvert[3] = 1;  //Gyro X  
  inpInvert[4] = 1;  //Gyro Y

  wGyro = 10;
  // Mark first sample equal to true and assign first Accelerometer raw data into raw estimation vector
  firstSample = 1;
  getEstimatedInclination();
}
void draw() {
  //println("Allah");
}


// Get Estimated method 
void getEstimatedInclination() {
  boolean loop = true;
  int ii = 0;
  float tmpf, tmpf2;
  final long newMicros;
  final int signRzGyro;

  // Get raw data from AX[0] AY[0] AZ[0]
  newMicros = second();     // Save the time when sample is taken

  while (loop) {
    an[0]  = AX[ii];
    an[1] = AY[ii];
    an[2] = AZ[ii];        
    println(newMicros, ii, an[0], an[1], an[2]);
    loop = false;
    ii++;
  }

  //Compute interval since last sampling time
  interval = newMicros - lastMicros;
  lastMicros = newMicros;

  //get accelerometer reading in g, gives us RwAcc vector
  for (int w = 0; w <=2; w++) {
    RwAcc[w] = getInput(w);
  }
  //println(RwAcc);

  // normalize vector ( convert to a vector with same direction and with length 1)
  normalize3DVector(RwAcc);
  //println(RwAcc);

  if (firstSample == 1) {
    for (int w=0; w<=2; w++) RwEst[w] = RwAcc[w];    //initialize with accelerometer readings
  } else {
    //evaluate RwGyro vector
    if (abs(RwEst[2]) < 0.1) {
      //Rz is too small and because it is used as reference for computing Axz, Ayz it's error fluctuations will amplify leading to bad results
      //in this case skip the gyro data and just use previous estimate
      for (int w=0; w<=2; w++) RwGyro[w] = RwEst[w];
    } else {
      //get angles between projection of R on ZX/ZY plane and Z axis, based on last RwEst
      for (int w=0; w<=1; w++) {
        tmpf = getInput(3 + w);                         //get current gyro rate in deg/ms
        tmpf *= interval / 1000.0f;                     //get angle change in deg
        Awz[w] = atan2(RwEst[w], RwEst[2]) * 180 / PI;   //get angle and convert to degrees        
        Awz[w] += tmpf;                                 //get updated angle according to gyro movement
      }

      //estimate sign of RzGyro by looking in what qudrant the angle Axz is, 
      //RzGyro is pozitive if  Axz in range -90 ..90 => cos(Awz) >= 0
      signRzGyro = ( cos(Awz[0] * PI / 180) >=0 ) ? 1 : -1;

      //reverse calculation of RwGyro from Awz angles, for formulas deductions see  http://starlino.com/imu_guide.html
      for (int w=0; w<=1; w++) {
        RwGyro[0] = sin(Awz[0] * PI / 180);
        RwGyro[0] /= sqrt( 1 + (cos(Awz[0] * PI / 180)*cos(Awz[0] * PI / 180)) * (tan(Awz[1] * PI / 180)*tan(Awz[1] * PI / 180)) );
        RwGyro[1] = sin(Awz[1] * PI / 180);
        RwGyro[1] /= sqrt( 1 + (cos(Awz[1] * PI / 180)*cos(Awz[1] * PI / 180)) * (tan(Awz[0] * PI / 180)*tan(Awz[0] * PI / 180)) );
      }
      RwGyro[2] = signRzGyro * sqrt(1 - (RwGyro[0]*RwGyro[0]) - (RwGyro[1]*RwGyro[1]));
    }

    //combine Accelerometer and gyro readings
    for (int w=0; w<=2; w++) {
      RwEst[w] = (RwAcc[w] + wGyro* RwGyro[w]) / (1 + wGyro);
    }

    normalize3DVector(RwEst);
  }
  firstSample = 0;
}

void normalize3DVector(float[] vector) {
  final float R;  
  R = sqrt(vector[0]*vector[0] + vector[1]*vector[1] + vector[2]*vector[2]);
  vector[0] /= R;
  //println(vector[0]);
  vector[1] /= R;
  //println(vector[1]); 
  vector[2] /= R;
  //println(vector[2]);
}

//For accelerometer it will return g (acceleration), applies when xyz = 0 to 2
//For gyro it will return deg/ms (rate of rotation ), applies when xyz = 3 to 5
float getInput(int i) {
  float tmpf = 0;
  tmpf = an[i] * VDD/1023.0f;   //voltage mV
  //println(tmpf);
  tmpf -= zeroLevel[i];         //voltage relative to zero level mV
  //println(tmpf);
  tmpf /= inpSens[i];           //input sensitivity in mv/G(acc) or mV/deg/ms(gyro)
  //println(tmpf);
  tmpf *= inpInvert[i];         //invert axis value according to cofiguration;
  //println(tmpf);
  return tmpf;
}

