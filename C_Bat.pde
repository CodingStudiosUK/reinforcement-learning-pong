class Bat {
  
  Brain brain;
  Trainer trainer;

  PVector pos;
  float speed = 6;
  int score = 0;
  float w = width*0.01, h = height*0.1;

  Bat(boolean side) {
    pos = new PVector(width*(side?0.9:0.1), height/2);
    int[] tempUhd = {3,2};
    brain = new Brain(this, 1, tempUhd, 1);
    trainer = new Trainer(this);
  }

  void run() {
    float[] inputs = {map(dist(0,pos.y,0,ball.pos.y),0,dist(0,0,width,height),0,1)};
    int choice = trainer.run(inputs);
    switch (choice){
      case UP:
        pos.y = constrain(pos.y-speed, h/2, height-h/2);
        break;
      case DOWN:
        pos.y = constrain(pos.y+speed, h/2, height-h/2);
        break;
      case CENTER:
        pos.y = constrain(pos.y, h/2, height-h/2);
        break;
    }
    if ((ball.pos.x-ball.size/2 < pos.x+w/2) && (ball.pos.x+ball.size/2 > pos.x-w/2)
      && (ball.pos.y-ball.size/2 < pos.y+h/2) && (ball.pos.y+ball.size/2 > pos.y - h/2)) {
        //ball.pos.sub(ball.vel);
      ball.vel.x *= -1;
    }
  }

  void display() {
    rect(pos.x, pos.y, w, h);
    stroke(255, 0, 0);
    for (int i = -2; i <= 3; ++i){
      line(width/2, pos.y+(i-0.5)*h, pos.x, pos.y+(i-0.5)*h);
    }
    noStroke();
  }
}
