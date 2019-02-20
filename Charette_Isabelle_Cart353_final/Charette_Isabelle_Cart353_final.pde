/**
 * Title: Expression through flight
 * Name: Isabelle Charette
 * Date: April 19th
 * Description: visualization of sound through firefly activity
 */

//SOFTWARE LICENSE : GNU Lesser General Public License
//http://www.gnu.org/licenses/lgpl-2.1.html

//orginial images from :
//http://enamorte.deviantart.com/art/Grungy-watercolor-texture-383919530
//copyrights : https://creativecommons.org/publicdomain/zero/1.0/deed.en
//&  http://free-stock-by-wayne.deviantart.com/art/Tree-12-380131320
//and modified!


//minim and fft andd audioInput code inspiredfrom https://vimeo.com/7596987 

//importation of minim library
import ddf.minim.analysis.*;
import ddf.minim.*;

//declaring flow field object
FlowField flowfield;

//declaring instance of a flock
Flock flock;

//declaring objects of minim classes
Minim minim;
AudioInput in;
FFT fft;

//variables playing a part in the flocking behavior
float neighbordist = 2;
float seperateDist = 20.0f;

//number of sound samples taken by the computer microphone
int numberOfSamples = 1024;

//number of fireflies in arraylist
int numberOfFireFlies = 20;

//size of the fireflies drawn
int sizeOfFireFlies = 20;

//force the luminous globes will attract the fireflies
float attractForce = 30;

//declaring and initilizing array of tree objects -- index must be an even number?
Forest[] tree = new Forest[2];

//declaring audio object
AudioInterface audio;

//declaring hover (which will repulse fireflies) object
Hover hover;
Hover hover2;
Hover hover3;

void setup() {

  //instiating hover object
  hover = new Hover(new PVector(width/3.75, height/2.35));
  hover2 = new Hover(new PVector(width/1.5, height/2));
  hover3 = new Hover(new PVector(width/3, height/1.5));

  //instiating flock object
  flock = new Flock();

  //instiating flowfield object
  flowfield = new FlowField(40);


  //for every element of the array...
  for (int i = 0; i < numberOfFireFlies; i++) {
    //... add a new firefly
    flock.addFireFly(new FireFly1(new PVector(width/2+random(-50, 50), height/2+random(-50, 50)), 15, 0.5));
  }

  //for every element in the array, add a new image a of a forest
  for (int i = 0; i < 2; i++) {
    tree[i] = new Forest(10, -height/4);
  }


  //initialize objects of minim library classes
  //this ; references to object in class, method, or processing sketch
  minim = new Minim(this);

  //collection of data: from both microphones(STEREO) and 1024 samples
  in = minim.getLineIn(Minim.STEREO, numberOfSamples);

  //create an array as big as in.bufferSize() and collect data at the speed of sampleRate() - usually 44.1HZ (the data being the sound input)
  fft = new FFT(in.bufferSize(), in.sampleRate());

  //initializing audio object
  audio = new AudioInterface();

  //size of window and color of background
  size(900, 900);
  background(0);
  smooth();
}

void draw() {
  //mix sound input of both microphones together
  fft.forward(in.left);

  //println("INPUT___" + in.mix);

  //fire initialize flowfield method
  flowfield.init();

  //background color redrawn each time draw() fires
  background(0);

  //call display method of hover object
  hover.display();
  hover2.display();
  hover3.display();

  //for every element in the array, call display method
  for (int i = 0; i < 2; i++) {
    tree[i].display(true);
  }

  //fire run method of flock object
  flock.run();

  //displays the flowfield
  //flowfield.display();

  //for every element in the array, fire display method of tree objects
  for (int i = 0; i < 2; i++) {
    tree[i].display(false);
  }
}

void keyPressed() {

  //when pressing this key, the fireflies come closer together over time
  if (key == '-') {

    //change the variable in cohesion and align vectors of flocking presets
    neighbordist = neighbordist + 20;

    //change the variable in seperate vector of flocking presets
    seperateDist = seperateDist - 20;
    //  println(neighbordist + "seperate");
  }

  //when pressing this key, the fireflies stretch further apart over time
  if (key == '+') {

    //change the variable in cohesion and align vectors of flocking presets
    seperateDist = seperateDist + 20;

    //change the variable in seperate vector of flocking presets
    neighbordist = neighbordist - 20;
  }
}