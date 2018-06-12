Ball ball;
Bat bat1, bat2;
//Test

void setup() {
  size(1280, 720, FX2D);//fullScreen(FX2D);
  frameRate(120);
  randomSeed(1);

  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(width*0.03);
  noSmooth();
  
  bat1 = new Bat(false);
  bat2 = new Bat(true);
  reset(random(0, TAU));
}

void draw() {
  background(0);
  
  ball.run();
  bat1.run();
  bat2.run();

  ball.display();
  bat1.display();
  bat2.display();
  text(bat1.score+" : "+bat2.score, width/2,height/5);
  println();
}

void reset(float dir) {
  ball = new Ball(dir);
  bat1.pos.y = height/2;
  bat2.pos.y = height/2;
}

void keyPressed() {
  reset(random(0, TAU));
}
