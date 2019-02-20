//subclass of FireFly
class FireFly1 extends FireFly {

  //1 of the images of the forest
  PImage img2;

  //constructor of subclass
  FireFly1(PVector l, float ms, float mf) {
    super(l, ms, mf);

    //loads image
    img2 = loadImage("bod.png");
  }

  //draws body and antennas of the firefly
  void bodyAndAntenna() {

    //antenna
    stroke(0, 0, 255);
    strokeWeight(1);
    line(0, -HIGH_BODY/2, OFFSET1, -HIGH_BODY/2-OFFSET1);
    line(0, -HIGH_BODY/2, -OFFSET1, -HIGH_BODY/2-OFFSET1);
    noStroke();

    //body
    tint(255, light.pulsingLight());
    // println(light.pulsingLight());

    //draws image at body position
    image(img2, -3*OFFSET1, -5*OFFSET1, WIDTH_BODY*1.5, HIGH_BODY*1.5);
    image(img2, -4*OFFSET1, -5*OFFSET1, WIDTH_BODY*2, HIGH_BODY*2);
    //fill(fillColor);
    //ellipse(0, 0, widthBody, highBody);
  }

  //draws left wings of firefly
  void LeftWings() {

    //left underwing
    pushMatrix();
    rotate(PI/5);
    noStroke();
    fill(100, 0, 255, 200);
    ellipse(-OFFSET1, OFFSET1/2, WIDTH_WINGS, HIGH_BODY);
    popMatrix();

    //left overwing
    pushMatrix();
    rotate(PI/4);
    noStroke();
    fill(100, 0, 255);
    ellipse(-OFFSET1*2, OFFSET1/1.5, WIDTH_WINGS, HIGH_BODY);
    popMatrix();
  }

  //draws right wings of firefly
  void RightWings() {
    //right underwing
    pushMatrix();
    rotate(-PI/5);
    noStroke();
    fill(100, 0, 255, 200);
    ellipse(OFFSET1, OFFSET1/2, WIDTH_WINGS, HIGH_BODY);
    popMatrix();

    //right overwing
    pushMatrix();
    rotate(-PI/4);
    noStroke();
    fill(100, 0, 255);
    ellipse(OFFSET1*2, OFFSET1/1.5, WIDTH_WINGS, HIGH_BODY);
    popMatrix();
  }

  void update() {
    super.update();
  }

  void applyForce(PVector soundForce) {
    super.applyForce(soundForce);
  }


  //draws fireflies
  void display() {

    //variable controlling the orientation of the fireflies so they follow the mouse
    float theta = velocity.heading2D() + PI/2;

    //save this graphic reference
    pushMatrix();

    //translate graphic origin to x , y
    translate(location.x, location.y);
    rotate(theta);

    //variable procuring jitter movement of the wings
    float randomJitter = random(PI/10);

    //draw the body and antenna
    bodyAndAntenna();  

    pushMatrix();

    //make wings jitter 
    rotate(randomJitter);

    //draws left wings
    LeftWings();
    popMatrix();

    pushMatrix();

    //make wings jitter 
    rotate(-randomJitter);

    //draws right wings
    RightWings();
    popMatrix();

    //set back to saved graphic reference
    popMatrix();
  }
}