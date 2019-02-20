// Flocking
// Daniel Shiffman <http://www.shiffman.net>
// The Nature of Code, Spring 2011
//**modifiedimp

// Flock class
//influences behavior of fireflies and makes they fly together
class Flock {

  //declaring array list of fireflies
  ArrayList <FireFly> fireflies;


  Flock() {
    fireflies = new ArrayList<FireFly>(); // Initialize the ArrayList
  }

  void run() {
    //for every firefly in FireFly class...
    for (FireFly b : fireflies) {

      //...fire run method
      b.run(fireflies);  // Passing the entire list of boids to each boid individually

      //...make it follow the flowfield
      b.follow(flowfield);

      //for every firefly, look up position and repulse from hover, hover2 and hover3
      PVector force = hover.repulse(b);
      b.applyForce(force);

      PVector force2 = hover2.repulse(b);
      b.applyForce(force2);

      PVector force3 = hover3.repulse(b);
      b.applyForce(force3);

    }
  }

  //method that adds elements the arraylist
  void addFireFly(FireFly b) {

    //adds fireflies to the arraylist
    fireflies.add(b);
  }
}