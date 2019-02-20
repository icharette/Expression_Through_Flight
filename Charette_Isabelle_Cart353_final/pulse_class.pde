//code originally from pulse assignment for Cart 253 with Jason, and modified 
class Pulse {

  float pulseCounter; // controls the pulsing
  float pulseSpeed; // pulse speed


  // constructor
  Pulse(float newSpeed) {
    pulseCounter = 0;
    pulseSpeed = newSpeed;
  }

  //function that returns the value with which the glow of the fireflies will pulsate
  float pulsingLight() {

    //how the value will fluctuate around 0 as a sin function
    float light = sin(pulseCounter);

    //increments pulseCounter, and changs value of light
    pulseCounter += pulseSpeed/4;

    //maps the value of fireLight so it actually changes the value of the tint from 0 to 255
    float fireLight = map(light, 0, 1, 0, 255);

    return fireLight;
  }
}