// PROCESSING .pde
// Combine accelerometer and gyro data and draw
// Version 1.0 (March, 2015).
// Abid Ali,
// IMaR Technology Gateway, Institute of Technology Tralee

Table table;
float[] AX;
float[] AY;
float[] AZ;

int INPUT_ACC = 3;
float PI = 3.14159265358979f;
float VDD = 5000.0f;



float[] an = new float[INPUT_ACC]; // number of accelerometer coordinates
char firstSample; // marks first sample;


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
    // println("Array "+ i+ " store : AX[" + AX[i]+"]" +" AY[" + AY[i]+"]" + " AZ[" + AZ[i]+"]");
    
    
  }
  int[] zeroLevel = new int[5];  // 0..2 accelerometer zero level (mV) @ 0 G
  int[] inpSens = new int[5];    // 0..2 acceleromter input sensitivity (mv/g)
  char[] inpInvert = new char[5]; // bits 0..5 invert input
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
    getEstimatedInclination();
    
}
// Get Estimated method 
void getEstimatedInclination(){
   final int i1, w;
   final float tmpf, tmpf2;
   final long newMicros;
   final char signRzGyro;

// Get data from AX[0] AY[0] AZ[0]
   newMicros = second();     // Save the time when sample is taken
   
   for(int i = 0; i <1 ; i++){
        float[] temp = new float[3];
        temp[i]  = AX[i];
        temp[i+1] = AY[i];
        temp[i+2] = AZ[i];        
     for(int j=0;j<3;j++){ 
       an[j]   = temp[j];
       
   }
   println(newMicros, i, an[i], an[i+1], an[i+2]);
 }
}

//float getInput(char i){
//  float tmpf = 0;
  
 // return tmpf;
//}

