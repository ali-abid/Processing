//PROCESSING
// Read x and y coordinates from text file and draw a 2D visual graph in Processing

BufferedReader reader;
String line;


void setup() {

  size (500, 500);
  rectMode(CENTER);
  smooth();
  reader = createReader("xy50.txt");
}
void draw() {
  background(204);
  try {
    line = reader.readLine();
  }
  catch(IOException e) {
    e.printStackTrace();
    line = null;
  }

  if (line == null)
  {
    noLoop();
  } else {
    String[] numXY = split(line, TAB);
    int x = int(numXY[0]);
    int y = int(numXY[1]);

    translate(width/2, height/2);
    // ellipse(50, 50,10,10);


    //float a = atan2(y-height/2, x-width/2);
    float a = atan2(y/2, x/2);
    rotate(a);
    delay(100);
    println(x);

    //println(mouseY);
    //println(mouseX);
    //fill(0);
    rect(20, 0, 240, 10);
    ellipse(150, 15, 30, 50);
    //output.println(a);
  }
}