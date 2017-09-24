abstract class Network {
  Node [] inNodes;
  Node [] outNodes;

  float [] run(float [] inValues) {
    if (inNodes.length!=inValues.length) {
      println("Number of input values does not match network"); 
      exit();
    }
    for (int k=0; k<inValues.length; k++) inNodes[k].a=inValues[k];
    evaluate();
    float [] result = new float[outNodes.length];
    for (int i=0; i<outNodes.length; i++) result[i]=outNodes[i].in;
    return result;
  }

  abstract void evaluate(); // the feed-forward algorithm
}

class SingleHiddenLayerNetwork extends Network {
  Node [] hidNodes;

  SingleHiddenLayerNetwork(int nInput, int nHidden, int nOutput) {
    inNodes =  new Node[nInput];     
    for (int i=0; i<nInput; i++)  inNodes[i]  = new Node();
    hidNodes = new Node[nHidden];    
    for (int h=0; h<nHidden; h++) hidNodes[h] = new Node();
    outNodes = new Node[nOutput];    
    for (int o=0; o<nOutput; o++) outNodes[o] = new Node();

    for (int k=0; k<nInput; k++)  for (int j=0; j<nHidden; j++) new Link(inNodes[k], hidNodes[j]);
    for (int j=0; j<nHidden; j++) for (int i=0; i<nOutput; i++) new Link(hidNodes[j], outNodes[i]);
  }

  void evaluate() {
    for (int j=0; j<hidNodes.length; j++) hidNodes[j].eval();
    for (int i=0; i<outNodes.length; i++) outNodes[i].eval();
  }

  void print() {
    println( "Input to hidden weights: ");
    for (int i=0; i<inNodes.length; i++)
    {
      String z=i+": "; 
      for (int j=0; j<hidNodes.length; j++) z+= " " + inNodes[i].linksOut[j].weight; 
      println(z);
    }
    println( "Hidden to output weights: ");
    for (int i=0; i<hidNodes.length; i++)
    {
      String z=i+": "; 
      for (int j=0; j<outNodes.length; j++) z+= " " + hidNodes[i].linksOut[j].weight; 
      println(z);
    }

    //println( "Hidden from input weights: ");
    //for(int i=0;i<hidNodes.length;i++)
    //  {String z=i+": "; for(int j=0;j<inNodes.length;j++) z+= " " + hidNodes[i].linksIn[j].weight; println(z);}


    //println( "Output from hidden  weights: ");
    //for(int i=0;i<outNodes.length;i++)
    //  {String z=i+": "; for(int j=0;j<hidNodes.length;j++) z+= " " + outNodes[i].linksIn[j].weight; println(z);}

    println();
  }
}