class Brain {
  
  Bat myBat;

  private Node[][] nodesVisible = new Node[2][]; //Staggered 2d array of Node objects that make up the BRAIN
  private Node[][] nodesHidden;

  private final float SYNAPSE_MIN = -1f; //Some constants to fine tune the NN, could have a drastic effect on evolution
  private final float SYNAPSE_MAX = 1f;

  Brain(Bat b, int lenInput, int[] lenHidden, int lenOutput) { //Default constructor, specify the lengths of each layer
    myBat = b;
    nodesVisible[0] = new Node[lenInput]; //Initialises the second dimension of the array
    nodesVisible[1] = new Node[lenOutput];

    for (int i = 0; i < nodesVisible[0].length; i++) {
      nodesVisible[0][i] = new Node(0);
    }

    nodesHidden = new Node[lenHidden.length][];
    for (int i = 0; i < nodesHidden.length; i++) {
      nodesHidden[i] = new Node[lenHidden[i]];
    }

    for (int i = 0; i < nodesHidden[0].length; i++) {
      nodesHidden[0][i] = new Node(nodesVisible[0].length);
    }

    for (int i = 1; i < lenHidden.length; i++) {
      for (int j = 0; j < lenHidden[i]; j++) {
        nodesHidden[i][j] = new Node(nodesHidden[i-1].length);
      }
    }

    for (int i = 0; i < nodesVisible[1].length; i++) { //Nested FOR loop, creates each node
      nodesVisible[1][i] = new Node(nodesHidden[nodesHidden.length-1].length);
    }
  }

  float[] propForward(float[] inputs) { //Propagates forward, passes inputs through the net and gets an output.
    // Input
    for (int j = 0; j < inputs.length; ++j) { //For the first layer, set the values.
      nodesVisible[0][j].setValue(inputs[j]);
    }
    // Hidden/Outer
    for (int i = 0; i < nodesHidden[0].length; ++i) { //Set the next layer
      nodesHidden[0][i].propForward(nodesVisible[0]);
    }
    for (int j = 1; j < nodesHidden.length; ++j) {
      for (int i = 0; i < nodesHidden[j].length; ++i) {
        nodesHidden[j][i].propForward(nodesHidden[j-1]);
      }
    }
    for (int i = 0; i < nodesVisible[1].length; ++i) {
      nodesVisible[1][i].propForward(nodesHidden[nodesHidden.length-1]);
    }

    // Get/return the outputs
    float[] output = new float[nodesVisible[nodesVisible.length-1].length]; //Gets the outputs from the last layer
    for (int i = 0; i < output.length; ++i) {
      output[i] = nodesVisible[nodesVisible.length-1][i].getValue();
      //output[i] = sig(output[i]);
    }

    return output; //Return them
  }

  class Node { //Node class, could use a dictionary or somethin similar but this creates more logical code (and more efficient!)
    // A given node has all the synapses connected to it from the previous layer.
    float synapse[], value = 0;

    Node(int synLen) { //Default constructer, for RANDOM initialisation
      synapse = new float[synLen];
      for (int i = 0; i < synLen; ++i) {
        synapse[i] = random(SYNAPSE_MIN, SYNAPSE_MAX);
      }
    }

    void propForward(Node[] nodes) { //Propagates forward, takes and array of the previous layer
      value = 0;
      for (int i = 0; i < nodes.length; ++i) { //Set my value to be the sum of each previous node * the synaps
        value += nodes[i].getValue()*synapse[i];
      }
      value = sig(value); ///MIGHT NEED TO BE ADJUSTED // Activation function, used to keep the values nice and small.
    }

    float getValue() {
      return value;
    }
    void setValue(float val) {
      this.value = val;
    }
    float getSynapse(int index) {
      return synapse[index];
    }
  }
}

float sig(float x) {
  return 1/(1+exp(-x));
}
float deriv(float x) {
  return sig(x)*(1-sig(x));
}
