final float THRESH = 0.35;

class Trainer{
  
  Bat myBat;
  
  float[][] reward = new float[19/*states*/][3/*actions*/]/*=reward, assuming perfect play from this point on*/;
  
  Trainer(Bat b){
    myBat = b;
    //Brain b = myBat.brain;
  }
  
  float reward() {
    return 23;
  }
  
  int run(float[] inputs){
    float out = myBat.brain.propForward(inputs)[0];
    int choice = out<THRESH?DOWN:out>1-THRESH?UP:CENTER;
    print(out+" ");
    return choice;
  }
  
}
