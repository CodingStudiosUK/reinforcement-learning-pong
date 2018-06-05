class Ball {

  PVector pos, vel;
  float speed = 7.0, size = 20.0;

  Ball(float dir) {
    pos = new PVector(width/2, height/2);
    vel = PVector.mult(PVector.fromAngle(dir), speed);
  }

  void run() {
    pos.add(vel);
    if (pos.y != constrain(pos.y, size, height-size)) {
      pos.y = constrain(pos.y, size, height-size);
      vel.y *= -1;
    }
    if (pos.x != constrain(pos.x, size, width-size)) {
      if (pos.x < width/2) {
        ++bat2.score;
        reset(random(-HALF_PI, HALF_PI));
      } else {
        ++bat1.score;
        reset(random(HALF_PI, PI+HALF_PI));
      }
    }
  }

  void display() {
    ellipse(pos.x, pos.y, size, size);
    stroke(255, 0, 0);
    line(bat1.pos.x, pos.y, bat2.pos.x, pos.y);
    noStroke();
  }
}
