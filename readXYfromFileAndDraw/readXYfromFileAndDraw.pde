// PROCESSING .pde
// Read x and y coordinates from text file and draw a 2D visual graph in Processing.
// Version 1.0 (Feb. 5, 2015).
// Abid Ali,
// IMaR Gateway Technology, Institute of Technology Tralee
//#define INPUT_COUNT 5
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
