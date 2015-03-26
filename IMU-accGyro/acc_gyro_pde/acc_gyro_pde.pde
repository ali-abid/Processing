// PROCESSING .pde
// Combine accelerometer and gyro data and draw
// Version 1.0 (March, 2015).
// Abid Ali,
// IMaR Gateway Technology, Institute of Technology Tralee

BufferedReader reader;
String line;
int count; int i; 
int[] AX;
void setup() {
  size(2, 2);
  // Open the file from the createWriter() example
  reader = createReader("countLine.txt");
}

void countLine() {
  try {
    line = reader.readLine();
  } 
  catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    // Stop reading because of an error or file is empty
    // Declare lenght of Array
    noLoop();
    println("Total number of lines in file: ",i);
    // Set length of arrays AX, AY, AZ, GX, GY
    count = i;
    AX = new int[count];    
  } else {
    //Counting number of lines in file
    //println(i);
    i++;
  }
} 

void storeValueInArray(){
  for(int i = 0; i < count; i++){
      AX[i] = i;
       println(AX[i]);
  }
}

void draw(){
  countLine();
  storeValueInArray();
}
