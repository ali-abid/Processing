// PROCESSING .pde
// Combine accelerometer and gyro data and draw
// Version 1.0 (March, 2015).
// Abid Ali,
// IMaR Gateway Technology, Institute of Technology Tralee

BufferedReader reader;
String line;
int count;
int[] AY;
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
    println(count);
    AX = new int[count];
    AY = new int[count];
    noLoop();
  } else {
    //Counting number of lines in file
    count++;
  }
} 

void readXYData() {
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
  } else {
    int i = 0;
    String[] pieces = split(line, TAB);
    AX[i] = int(pieces[0]);
    AY[i] = int(pieces[1]);
    i++;
  }
} 

void draw(){
  countLine();
  //readXYData();
}
