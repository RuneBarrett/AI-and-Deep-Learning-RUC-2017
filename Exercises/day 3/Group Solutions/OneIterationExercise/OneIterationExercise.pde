void setup() {

  // -------------- Feed forward algorithm
  //For each node, take the sigmoid of input1*weightX + input2*weightX
  //Node 1
  println("SigmN11: " + sigmoid(summer(.2, .3, .2, .5))); //hidden 1
  println("SigmN12: " + sigmoid(summer(.5, .1, .2, .3))); //hidden 2

  //Node 2
  println("SigmN21: " + sigmoid(summer(.47, .5, .46, .7))); //out 1
  println("SigmN22: " + sigmoid(summer(.47, .6, .46, .8))); //out 2

  // -------------- Back propegation algorithm
  //Compute error of output/expected output
  println("Err1: "+err(.7, .36));
  println("Err2: "+err(.3, .34));

  //Compute delta of the output nodes
  println("SigmDerive1: "+sigmoidDerive(.34, 0.36));
  println("SigmDerive2: "+sigmoidDerive(.04, 0.34));

  //Compute new weights on links between the (last pair of) hidden nodes and the output nodes
  println("w1lini: "+newWeigth(.5, 0.47, 0.08));
  println("w2lini: "+newWeigth(.5, 0.46, 0.01));
  println("w1diag: "+newWeigth(.5, 0.47, 0.01));
  println("w2diag: "+newWeigth(.5, 0.46, 0.08));

  //Compute delta of the hidden nodes
  println("Delta1: "+deltaFunc(0.47, 0.08, 0.01, 0.019, 0.0023));
  println("Delta2: "+deltaFunc(0.46, 0.08, 0.01, 0.018, 0.0023 ));

  //compute new weights on links between input nodes and (the first pair) of hidden nodes
  println("nw1lini: "+newWeigthTwo(0.5, 0.1, .47, 0.0004));
  println("nw2lini: "+newWeigthTwo(0.5, 0.4, .46, 0.0004));
  println("nw1diag: "+newWeigthTwo(0.5, 0.3, .47, 0.0004));
  println("nw2diag: "+newWeigthTwo(0.5, 0.2, .46, 0.0004));
}

float sigmoid(float in) {
  return 1/(1+pow(2.71828182846, in));
}

float summer(float a1, float w1, float a2, float w2) {
  return a1*w1 + a2*w2;
}

float err(float o, float t) {
  return t - o;
}

float sigmoidDerive( float err, float in) {
  return err * (sigmoid(in) * (1-sigmoid(in)));
}

float sigmoidDeriveNoErr(float in) {
  return (sigmoid(in) * (1-sigmoid(in)));
}

float newWeigth(float alpha, float a, float delta) {
  return alpha*a*delta;
}

float deltaFunc(float inj, float di, float dj, float nw1, float nw2) {
  return sigmoidDeriveNoErr(inj) * nw1 * di + nw2 * dj;
}

//wjk = wjk+alpha*aK*deltaK
float newWeigthTwo(float alpha, float wjk, float aK, float deltaK) {
  return wjk+alpha*aK*deltaK;
}