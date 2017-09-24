// splitting a TableRow into an input and and output "vector"

float [] getInput(TableRow tr, int nIns, int nOuts) {
  float [] result = new float [nIns];
  for (int i=0; i<nIns; i++) result[i]=tr.getFloat(i);
  return result;
}


float [] getTarget(TableRow tr, int nIns, int nOuts) {
  float [] result = new float [nOuts];
  for (int i=0; i<nOuts; i++) result[i]=tr.getFloat(nIns+i);
  return result;
}

float [] arrayMinus(float [] a, float [] b) {
  if (a.length!=b.length) {
    println("Trying to subtract two arrays of different lenght: " + a +" "+b);
    exit();
  }
  float [] result = new float[a.length];
  for (int i=0; i<a.length; i++) result[i]=a[i]-b[i];
  return result;
}

float sigmoid(float x) {
  return 1/(1+ exp(-x));
}

float sigmoidDerivative(float x) {
  float s=sigmoid(x);
  return s*(1-s);
}

/*float summarizeWeightsInList(Node [] aToSum) {
  float sum = 0;
    for (int i = 0; i < aToSum.length;i++ ) {
      sum += aToSum.weight * aToSum.to.delta;
    }
 
  return sum;
}*/

//float summer(float a1, float w1, float a2, float w2) {return a1*w1 + a2*w2;}

////////////////

void printFloats(String init, float [] a) {
  String s=init; 
  for (int i=0; i<a.length; i++) s+= " " + a[i]; 
  println(s);
}