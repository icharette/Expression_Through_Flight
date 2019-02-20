//class that draws the forest background
class Forest {

  //declaring two images
  PImage img1;
  PImage img2;

  //position of images
  float x;
  float y;

  //construction
  Forest(float x_, float y_) {
    x = x_;
    y = y_;

    //loading images
    img1 = loadImage("forest1.png");
    img2 = loadImage("forest2.png");
  }

  //method that displays the forests according to type (I have to images that will appear one over the other with the fireflies in between to give a feeling of deapth)
  void display(boolean forestType) {

    //if boolean is true
    if (forestType) {

      //draws this forest
      tint(255);
      image(img1, x, y);

      //otherwise, draw this forest
    } else {
      tint(255);
      image(img2, x, y);
    }
  }
}