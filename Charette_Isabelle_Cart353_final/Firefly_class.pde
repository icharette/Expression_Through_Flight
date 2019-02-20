//class that draws fireflies
//pieces of code from Shiffman Nature of Code and modified
class FireFly {
  int counter = 0 ;

  //declaring pulse object
  Pulse light;

  //declartion of vectors controlling the position and movement of the fireflies
  PVector location;
  PVector velocity;
  PVector acceleration;

  //variables controlling the movement of the fireflies
  final float MAX_SPEED;
  final float MAX_FORCE;
  final float threshold = 30;

  //variables controlling the drawing of the fireflies
  final float HIGH_BODY = sizeOfFireFlies;
  final float WIDTH_BODY = HIGH_BODY*2/3.5;
  final float WIDTH_WINGS = WIDTH_BODY/2;
  final float OFFSET1 = WIDTH_WINGS/2;

  //constructor
  FireFly(PVector l, float ms, float mf) {
    location = l.get();
    MAX_SPEED = ms;
    MAX_FORCE = mf;

    //initializing vectors
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);

    //initializing light object
    light = new Pulse(random(1));
  }

  //method that regroups all methods of Firefly class
  void run(  ArrayList <FireFly> fireflies) {

    //increments counter...
    counter ++;

    //update position of fireflies
    update();

    //verify if at the borders
    borders();

    //apply flock behavior to fireflies
    flock(fireflies);

    //display the fireflies
    display();

    //if there is no sound recorded... (or very little)
    if ( audio.getVolume() < 0.03) {

      //make the luminous globes (Hover) attractors 
      hover.state = attractForce;
      hover2.state = attractForce;
      hover3.state = attractForce;

      //if the fireflies enter the range of the luminous globes (Hover) make them slow down
      if ((PVector.sub(location, hover.location)).mag() < threshold ||(PVector.sub(location, hover2.location)).mag() < threshold || (PVector.sub(location, hover3.location)).mag() < threshold) {

        velocity = new PVector(0, 0);
        acceleration = new PVector(0, 0);
      }
    }

    //if there is  sound recorded... 
    if (audio. getVolume() >= 0.03) {

      //make the luminous globes repulsors
      hover.state = -1;
      hover2.state = -1;
      hover3.state = -1;

      //when counter is dividable by 100, fire following code
      if (counter%100==0) {

        //if the frequency recorded if smaller than 4250 kHz and bigger than 4000....
        if (audio.averageFreq() < 4250 || audio.averageFreq() > 4000) {

          //...apply this force the position of the firefles
          applyForce(new PVector(0, 10));

          //if the frequency recorded if smaller than 4500 kHz and bigger than 4250....
        } else if (audio.averageFreq() < 4500 || audio.averageFreq() > 4250) {

          //...apply this force the position of the firefles
          applyForce(new PVector(10, 10));

          //if the frequency recorded if smaller than 4500 kHz and bigger than 5000....
        } else if (audio.averageFreq() < 4500 || audio.averageFreq() > 5000) {

          //...apply this force the position of the firefles
          applyForce(new PVector(-10, 0));
        }
      }
    }
  }

  //method that influences the fireflies position
  void follow(FlowField flow) {

    // What is the vector at that spot in the flow field?
    PVector desired = flow.lookup(location);

    // Scale it up by maxspeed
    desired.mult(MAX_SPEED);

    // Steering is desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(MAX_FORCE*2.5);  // Limit to maximum steering force
    applyForce(steer);
  }

  //methods that applies force to acceleration
  void applyForce(PVector soundForce) {
    acceleration.add(soundForce);
  }

  //methods updating the movement of fireflies
  void update() {

    //variable containing data of sound: lounder the sound, faster the movement
    float volumeSpeed = audio.getVolume();

    //if the sound is at a certain volume, move faster
    if (volumeSpeed > 0.01) {
      acceleration.mult(volumeSpeed*10);
    }

    //interaction between vectors
    velocity.add(acceleration);
    velocity.limit(MAX_SPEED);
    location.add(velocity);
    acceleration.mult(0);
  }

  //method that draws firefly
  void display() {
  }

  //method that resets the position of the fireflies when they hit the borders
  void borders() {
    if (location.x < 0) {
      location.x = width;
    }
    if (location.y < 0) {
      location.y = height;
    }
    if (location.x > width) {
      location.x = 0;
    }
    if (location.y > height) {
      location.y = 0;
    }
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(  ArrayList <FireFly> fireflies) {
    PVector sep = separate(fireflies);   // Separation
    PVector ali = align(fireflies);      // Alignment
    PVector coh = cohesion(fireflies);   // Cohesion

    // Arbitrarily weight these forces
    //fireflies steer to avoir colliding
    sep.mult(4.75);

    //steer in same direction as others
    ali.mult(5.5);

    //sterr towards center of other fireflies
    coh.mult(2.75);

    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, location);  // A vector pointing from the location to the target

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(MAX_SPEED);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(MAX_FORCE);  // Limit to maximum steering force
    return steer;
  }

  // Separation
  // Method checks for nearby fireflies and steers away
  PVector separate (  ArrayList <FireFly> fireflies) {
    float desiredseparation = seperateDist;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;

    // For every firefly in the system, check if it's too close
    for (FireFly other : fireflies) {
      float d = PVector.dist(location, other.location);

      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {

        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }

    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(MAX_SPEED);
      steer.sub(velocity);
      steer.limit(MAX_FORCE);
    }
    return steer;
  }

  // Alignment
  // For every nearby firefly in the system, calculate the average velocity
  PVector align (  ArrayList <FireFly> fireflies) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (FireFly other : fireflies) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(MAX_SPEED);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(MAX_FORCE);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby fireflies, calculate steering vector towards that location
  PVector cohesion (  ArrayList <FireFly> fireflies) {
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (FireFly other : fireflies) {
      float d = PVector.dist(location, other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the location
    } else {
      return new PVector(0, 0);
    }
  }
}