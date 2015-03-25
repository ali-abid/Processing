// PROCESSING .pde
// Combine accelerometer and gyro data and draw
// Version 1.0 (March, 2015).
// Abid Ali,
// IMaR Gateway Technology, Institute of Technology Tralee

BufferedReader reader;
String line;

void setup() {
  size(2,2);
  // Open the file from the createWriter() example
  reader = createReader("xy.txt");   
}

void draw() {
  try {
    line = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    // Stop reading because of an error or file is empty
    noLoop(); 
  } else {
    String[] pieces = split(line, TAB);
    int x = int(pieces[0]);
    int y = int(pieces[1]);
    point(x, y);
    println(line);
  }
} 
