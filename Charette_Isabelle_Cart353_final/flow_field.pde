//code from The Nature OF Code - DANIEL SHIFFMAN
//and modified**

//class the indicates the main path for the fireflies to follow
class FlowField {

  int counter = 0;

  //variable to access volume data
  float volume;
  float yoff = 0;

  // A flow field is a two dimensional array of PVectors
  PVector[][] field;
  int cols, rows; // Columns and Rows
  int resolution; // How large is each "cell" of the flow field

  FlowField(int r) {
    resolution = r;

    // Determine the number of columns and rows based on sketch's width and height
    cols = width/resolution;
    rows = height/resolution;
    field = new PVector[cols][rows];
  }

  void init() {
    //connect variable to volume recorded by computer
    volume = audio.getVolume();

    //angle of flowfield vectors
    float theta = 0 ;

    //for every flowfield vector....
    for (int i = 0; i < cols; i++) {

      for (int j = 0; j < rows; j++) {

        //...if the volume is high
        if (volume>1) {

          //increment theta
          theta = theta + 10;
        } else if(volume<1) {

          //or else decrement it
          theta = theta - 10;
        }

        //assignment theta values to the vectors
        // Polar to cartesian coordinate transformation to get x and y components of the vector
        field[i][j] = new PVector(cos(theta), sin(theta));
      }
    }
  }

  // Draw every vector
  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        drawVector(field[i][j], i*resolution, j*resolution, resolution-2);
      }
    }
  }

  // Renders a vector object 'v' as an arrow and a location 'x,y'
  void drawVector(PVector v, float x, float y, float scayl) {
    pushMatrix();
    float arrowsize = 4;

    // Translate to location to render vector
    translate(x, y);
    stroke(255);

    // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
    rotate(v.heading2D());

    // Calculate length of vector & scale it to be bigger or smaller if necessary
    float len = v.mag()*scayl;

    // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
    line(0, 0, len, 0);
    popMatrix();
  }

  PVector lookup(PVector lookup) {
    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[column][row].get();
  }
}