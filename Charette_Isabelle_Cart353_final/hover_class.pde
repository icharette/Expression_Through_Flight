//class of the luminous globes which repulse the fireflies
class Hover {
  
  //if there is sound, then the luminous globes repulse the fireflies, if there is very little sound or none then they will attract them
  float state = -1;
  //size of the luminous globes
  float hoverSize;

  //how strong they repulse the fireflies
  float coefficientForce;

  //location of the lumiinous globes
  PVector location;

  //constructor
  Hover(PVector location_) {
    location = location_;


    //assign values to size and strength
    hoverSize = 70;
    coefficientForce = 500;
  }

  //function that returns the force with which to repulse the fireflies according to their position to the luminous globe
  PVector repulse(FireFly firefly) {

    //distance in vector format between firefly element and repulsor
    PVector force = PVector.sub(location, firefly.location);

    //calculate distance from magnitude of vector
    float distance = force.mag();

    //normalize the vector to have orientation
    force.normalize();

    //calculate strength of repulsion
    float strength = state*(coefficientForce)/(distance*distance);

    //multiply it to the force vector
    force.mult(strength);
    return force;
  }

  //method that displays the repulsor
  void display() {
    noStroke();
    fill(255, 100);
    ellipse(location.x, location.y, hoverSize, hoverSize);

    fill(255, 200);
    ellipse(location.x + 20, location.y + 10, hoverSize/2, hoverSize/2);

    fill(255, 220);
    ellipse(location.x, location.y, hoverSize/1.5, hoverSize/1.5);

    fill(255, 200);
    ellipse(location.x, location.y, hoverSize/1.1, hoverSize/1.1);

    fill(255, 200);
    ellipse(location.x + hoverSize/4, location.y +hoverSize/2, hoverSize/5, hoverSize/5);


    fill(255, 150);
    ellipse(location.x + hoverSize/4, location.y +hoverSize/2, hoverSize/3, hoverSize/3);

    fill(255, 220);
    ellipse(location.x + hoverSize/20, location.y + hoverSize/2, hoverSize/7, hoverSize/7);
  }
}