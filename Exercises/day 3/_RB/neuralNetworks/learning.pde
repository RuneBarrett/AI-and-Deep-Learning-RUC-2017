float learningRate = 0.65; 

void train(SingleHiddenLayerNetwork net, Table trainingData) {
  int inputSize = net.inNodes.length;
  int outputSize = net.outNodes.length;
  if (trainingData.getColumnCount()!=inputSize+outputSize) {
    println("Table of training data does not fit no. of input and output nodes");
    exit();
  }

  boolean finished = false;
  int count=8000;
  int cc = count;
  while (!finished) { // each iteration is an epoch
    if (count%1000==0) println(cc-count, "epochs processed in", millis()/1000, millis()/1000 != 1 ? "seconds." : "second.");
    for (int ex=0; ex<trainingData.getRowCount(); ex++) { // process one sample tuple
      //For the first 90% of the training data, train
      if (ex < trainingData.getRowCount()*0.9) {
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
      } else //for the rest 10%, test the accuracy
      { 
        
      }
    } // end process one sample tuple  
    count--;
    finished = (count<=0);
  }//end epoch
}