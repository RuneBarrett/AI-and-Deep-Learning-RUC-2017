float btnStartPos = 0.34;
ArrayList<clickBox> hoverBoxes = new ArrayList();

void mousePressed() {
  float btnWidth = width*0.08;
  float btnHeight = height*0.05;

  // Random input
  if (mouseX > width*btnStartPos && mouseX < width*btnStartPos+width*0.08 && mouseY > height-(height*0.05)) {
    statStr = "";
    float [] _input = {random(-0.9, 0.9), random(-0.9, 0.9)};
    //output = myNetwork.run(input);
    input = _input;
    //output = _output;
    //printFloats("Is this roughly ", input, output);
    //draw = true;
    netUpdate();
  }

  /* Test with cumulative accuracy error */
  ArrayList<Float> stats = new ArrayList();
  //netUpdate();
  if (mouseX > width*btnStartPos+btnWidth && mouseX < width*btnStartPos+btnWidth*2 && mouseY > height-btnHeight) {
    for (int i = 0; i < 1000; i++) {
      float [] _input = {random(-0.9, 0.9), random(-0.9, 0.9)};
      float [] _output = myNetwork.run(_input);
      stats.add(drawStats(_input, _output, true));
    }

    float cumulativeError = 0;
    for (int i = 0; i < stats.size(); i++)
      cumulativeError += stats.get(i);
    statStr = "Testing the network with 5000 random input pairs between (-0.9, 0.9),\nyielding a cumulative accuracy error of "+nf(cumulativeError/stats.size(), 0, 2) +"%";
  }

  /* Train the network */
  if (mouseX > width*btnStartPos+btnWidth*2 && mouseX < width*btnStartPos+btnWidth*3 && mouseY > height-btnHeight) {
    statStr = "";
    textSize(50);
    background(0, 0, 50);
    fill(255);
    text("Learning...", width*0.4, height/2);
    train = true;
  }

  if (mouseX > width*btnStartPos+btnWidth*3 && mouseX < width*btnStartPos+btnWidth*4 && mouseY > height-btnHeight) {
    weightColors = !weightColors;
    netUpdate();
  }
}

void buttons() {
  float btnWidth = width*0.08;
  float btnHeight = height*0.05;
  stroke(0);
  strokeWeight(3);
  textSize(18);
  fill(0, 150, 230);
  rect(width*btnStartPos, height-btnHeight, btnWidth, btnHeight);
  fill(0);
  text("Rand. Input", width*btnStartPos*1.015, height-btnHeight/2+5);

  fill(0, 125, 230);
  rect(width*btnStartPos+btnWidth, height-btnHeight, btnWidth, btnHeight);  
  fill(0);
  text("Test", width*btnStartPos*1.075+btnWidth, height-btnHeight/2+5);

  fill(0, 100, 230);
  rect(width*btnStartPos+(btnWidth*2), height-btnHeight, btnWidth, btnHeight);  
  fill(0);
  text("Train", width*btnStartPos*1.072+(btnWidth*2), height-btnHeight/2+5);

  fill(0, 75, 230);
  rect(width*btnStartPos+(btnWidth*3), height-btnHeight, btnWidth, btnHeight);  
  fill(0);
  text("Weight Col.", width*btnStartPos*1.02+(btnWidth*3), height-btnHeight/2+5);
}

class clickBox {
  float x1, y1, x2, y2;
  Node n;
  int type;
  clickBox(float x1, float y1, float x2, float y2, Node n, int type) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.n = n;
    this.type = type;
  }

  void drawBox() {
    info = "";
    strokeWeight(3);
    fill(0, 0, 120);
    rect(width*0.75, height*0.72, width*0.2, height*0.25);
    String str = "";
    switch(type) {
    case 0:
      str += "Input node\n";
      //str += "   in = "+n.in+"\n";
      str += "   a = "+n.a+"\n";
      str += "\nLinks out: \n";
      for (int i = 0; i<n.linksOut.length; i++)
        str += "   L"+(i+1)+" = "+nf(n.linksOut[i].weight, 0, 3)+"\n";

      break;
    case 1:
      str += "Hidden node\n";
      str += "Feed Forward -->\n";
      for (int i = 0; i < n.linksIn.length; i++)
        str += (String)(i==0 ? "   ":"")+"("+nf(n.linksIn[i].from.a, 0, 3)+"*"+nf(n.linksIn[i].weight, 0, 3)+") "+ (String)(i+1==n.linksIn.length ? "=":"+") +" " + (String)(i%2==0 ? "":"\n");
      str += "   in = " + nf(n.in, 0, 3) + "\n";
      str += "   sigmoid(in) = a = "+nf(n.a, 0, 3)  + "\n";
      str += "\nBack Propegate <--\n";
      str += "   deltaJ = g'("+nf(n.in, 0, 3)+") * \n";
      float holder = 0;
      for (int i = 0; i < n.linksOut.length; i++) {
        str += (String)(i==0 ? "   [":"")+nf(n.linksOut[i].weight, 0, 3) + " * " + nf(n.linksOut[i].to.delta, 0, 3)+ (String)(i+1==n.linksIn.length ? "] \n ":" + ");
        holder += n.linksOut[i].weight*n.linksOut[i].to.delta;
      }
      str += "   = "+nf(sigmoidDerivative(n.in) + holder, 0, 3)+ "\n";
      str += "\nCurrent delta: "+nf(n.delta, 0, 4) ;


      break;
    case 2:
      str += "Output node\n";
      str += "   Error = \n";
      break;
    }
    boxStr = str;
  }
}