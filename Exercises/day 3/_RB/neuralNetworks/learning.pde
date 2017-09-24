float learningRate = 0.02; 

void train(SingleHiddenLayerNetwork net, Table trainingData) {
  int inputSize = net.inNodes.length;
  int outputSize = net.outNodes.length;
  if (trainingData.getColumnCount()!=inputSize+outputSize) {
    println("Table of training data does not fit no. of input and output nodes");
    exit();
  }

  boolean finished = false;
  int count=1000;
  while (!finished) { // each iteration is an epoch
    for (int ex=0; ex<trainingData.getRowCount(); ex++) { // process one sample tuple
      float [] input =   getInput(trainingData.getRow(ex), inputSize, outputSize);
      float [] target = getTarget(trainingData.getRow(ex), inputSize, outputSize);

      /* Compute the output for this example, storing values of “ini” and “ai” for each node */
      float [] out = net.run(input);

      /* Shorten [] names */
      Node [] outs = net.outNodes; 
      Node [] hids = net.hidNodes;
      Node [] inps = net.inNodes;

      /* Compute the error and ∆ for units in the output layer */
      float [] err = arrayMinus(target, out);

      for (int i = 0; i<outs.length; i++) {
        outs[i].delta = err[i] * sigmoidDerivative(outs[i].in);
      }

      /* Update the weights leading to the output layer */
      for (int i = 0; i<outs.length; i++) {
        for (int j = 0; j<outs[i].linksIn.length; j++) {
          outs[i].linksIn[j].weight = outs[i].linksIn[j].weight + learningRate * outs[i].linksIn[j].from.a * outs[i].delta;
          //hids[i].linksOut[j].weight = outs[i].linksIn[j].weight; //outs[i].linksIn[j].weight + learningRate * hids[j].a * outs[i].delta;
        }
      }

      /* Update the weights in hidden layers */
      //only one layer in LN−1,...,L1 (hids) no loop needed

      /* Compute the error term at each node */
      for (int j = 0; j<hids.length; j++) {
        float sum = 0;
        for (int i = 0; i < hids[j].linksOut.length; i++) sum += hids[j].linksOut[i].weight * hids[j].linksOut[i].to.delta;
        hids[j].delta = sigmoidDerivative(hids[j].in) * sum;

        /* Update weights leading to layer L */
        for (int k = 0; k<inps.length; k++) {
          hids[j].linksIn[k].weight = hids[j].linksIn[k].weight + learningRate * hids[j].linksIn[k].from.a * hids[j].delta;
        }
      }


      /*
      float w11 = net.inNodes[0].linksOut[0].weight;
       float w12 = net.inNodes[1].linksOut[0].weight;
       float w21 = net.inNodes[0].linksOut[1].weight;
       float w22 = net.inNodes[1].linksOut[1].weight;
       
       float in1 = input[0]*w11 + input[1]*w12;
       float in2 = input[0]*w21 + input[1]*w22;
       float a1 = sigmoid(in1);
       float a2 = sigmoid(in2);
       
       float w31 = net.hidNodes[0].linksOut[0].weight;
       float w32 = net.hidNodes[1].linksOut[0].weight;
       float w41 = net.hidNodes[0].linksOut[1].weight;
       float w42 = net.hidNodes[1].linksOut[1].weight;
       
       float out1 = a1*w31 + a2*w32;
       float out2 = a1*w41 + a2*w42;
       
       float err1 = target[0]-out1;
       float err2 = target[0]-out2;
       
       float deltaOut1 = err1*sigmoidDerivative(out1);
       float deltaOut2 = err2*sigmoidDerivative(out2);
       
       net.hidNodes[0].linksOut[0].weight = alpha * a1 * deltaOut1;
       net.hidNodes[0].linksOut[1].weight = alpha * a1 * deltaOut2;
       net.hidNodes[1].linksOut[0].weight = alpha * a2 * deltaOut1;
       net.hidNodes[1].linksOut[1].weight = alpha * a2 * deltaOut2;
       
       float deltaHid1 = sigmoidDerivative(in1) * (net.hidNodes[0].linksOut[0].weight*deltaOut1 + net.hidNodes[0].linksOut[1].weight*deltaOut2);
       float deltaHid2 = sigmoidDerivative(in2) * (net.hidNodes[1].linksOut[0].weight*deltaOut1 + net.hidNodes[1].linksOut[1].weight*deltaOut2);
       
       net.inNodes[0].linksOut[0].weight = net.inNodes[0].linksOut[0].weight + alpha * a1 * deltaHid1;
       net.inNodes[1].linksOut[0].weight = net.inNodes[1].linksOut[0].weight + alpha * a1 * deltaHid1;
       net.inNodes[0].linksOut[1].weight = net.inNodes[0].linksOut[1].weight + alpha * a2 * deltaHid2;
       net.inNodes[1].linksOut[1].weight = net.inNodes[1].linksOut[1].weight + alpha * a2 * deltaHid2;
       */
    } // end process one sample tuple  
    count--;
    finished = (count<=0);
  }//end epoch
}