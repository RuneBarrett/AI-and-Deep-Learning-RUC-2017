ArrayList<Point> inPoints, hidPoints, outPoints; //<>// //<>// //<>//

void drawNodesSHL(SingleHiddenLayerNetwork net, int r) {

  //Draw input layer
  float yS = height/1/(net.inNodes.length+1); 
  float y = yS; 
  float x = width*0.25;
  inPoints = new ArrayList();
  for (int i = 0; i < net.inNodes.length; i++) {
    drawNode("a = "+nf(net.inNodes[i].a, 0, 3), x, y, r, net.inNodes[i], 0); 
    inPoints.add(new Point(x, y));
    y += yS;
  }

  //Draw hidden layer
  yS = height/1/(net.hidNodes.length+1); 
  y = yS; 
  x = width*0.5;
  hidPoints = new ArrayList();

  for (int i = 0; i < net.hidNodes.length; i++) {
    drawNode("s(a) = "+nf(net.hidNodes[i].a, 0, 3), x, y, r, net.hidNodes[i], 1); 
    hidPoints.add(new Point(x, y));
    y += yS;
  }

  //Draw output layer
  yS = height/1/(net.outNodes.length+1); 
  y = yS; 
  x = width*0.75;
  outPoints = new ArrayList();

  for (int i = 0; i < net.outNodes.length; i++) {
    drawNode("\"in\" = "+nf(net.outNodes[i].in, 0, 3), x, y, r, net.outNodes[i], 2); 
    outPoints.add(new Point(x, y));
    y += yS;
  }
}

void drawNode(String t, float posX, float posY, int radius, Node n, int type) {
  stroke(100, 20, 255);
  strokeWeight(3);
  fill(0, 220, 0);
  ellipse(posX, posY, radius, radius);
  fill(100, 20, 255);
  noStroke();
  ellipse(posX, posY, radius*0.3, radius*0.3);

  fill(0, 255, 255);
  textSize(16);
  hoverBoxes.add(new clickBox(posX-radius*0.7, posY-radius*0.7, posX+radius*0.7, posY+radius*0.7, n, type));

  if (posY > height*0.5) posY+=radius*1.7;
  text(t, posX-radius*0.8, posY-radius*0.7);
}

void drawLinksSHL(SingleHiddenLayerNetwork net, int r) {
  stroke(100, 20, 255);
  strokeWeight(3);
  textSize(14);
  drawLinks(net, inPoints, hidPoints, r, 0.1, 0.05, true);
  drawLinks(net, hidPoints, outPoints, r, 0.1, 0.90, false);
}

void drawLinks(SingleHiddenLayerNetwork net, ArrayList<Point> L1, ArrayList<Point> L2, int r, float yStart, float xStart, boolean left) {
  //From L1 to L2
  int weightEllipseColor = 20;
  int count = 0;
  int y = (int)(height*yStart);
  float offset = 0.12;
  String s = left ? "Inp to hid weights" : "Hid to out weights";
  fill(255);
  text(s, width*xStart-width*0.01, height*yStart);
  for (int i = 0; i < L1.size(); i++)
    for (int j = 0; j < L2.size(); j++) {
      /* Shorten calls */
      float L1_X = L1.get(i).x;
      float L1_Y = L1.get(i).y;
      float L2_X = L2.get(j).x;
      float L2_Y = L2.get(j).y;

      /* Link line */
      line(L1_X, L1_Y, L2_X, L2_Y);

      /* Increment weight ellipse color and fill */
      fill(50, weightEllipseColor+=10, 50); 

      /* Draw weight ellipse on link line */
      Point p = (left ? PointOnLine(L1_X, L1_Y, L2_X, L2_Y, width*offset) : PointOnLine(L2_X, L2_Y, L1_X, L1_Y, width*offset));
      ellipse(p.x, p.y, r, r);

      /* Weight ellipse left side */
      ellipse(width*xStart, y+=r*1.3, r, r);

      fill(255);
      /* Text for link ellipses */
      text(++count, p.x-r*0.2, p.y+r*0.25);
      text(count, width*xStart-r*0.2, y+r*0.25);

      /* Weight text */      // Only works with single layer
      if (left) text(nf(net.inNodes[i].linksOut[j].weight, 0, 3), width*xStart+r, y+r*0.25);
      else text(nf(net.hidNodes[i].linksOut[j].weight, 0, 3), width*xStart+r, y+r*0.25);

      //println(nf(net.inNodes[i].linksOut[j].weight, 0, 4));
    }
}

void mouseHover() {
  boolean hover = false;
  for (int i = 0; i < hoverBoxes.size(); i++) {
    if (mouseX > hoverBoxes.get(i).x1 && mouseX < hoverBoxes.get(i).x2 
      && mouseY > hoverBoxes.get(i).y1 && mouseY < hoverBoxes.get(i).y2) {
      hover = true;
      hoverBoxes.get(i).drawBox();
      //rect(width*0.75, height*0.75, width*0.2, height*0.2);
      fill(255);
      textSize(16);
      text(boxStr, width*0.76, height*0.74);
    }
  }
  if (!hover && myNetwork != null) {
    netUpdate(); 
    boxStr="";
  }
}

void drawInputOutput(float [] input, float [] output) {
  textSize(26);
  text("Input: <"+nf(input[0], 0, 3)+", "+nf(input[1], 0, 3)+">", width*0.12, height/2);
  text("Target output: <"+nf(input[0]+input[1], 0, 3)+", "+nf(input[0]-input[1], 0, 3)+">", width*0.38, height*0.93);
  text("Output: <"+nf(output[0], 0, 3)+", "+nf(output[1], 0, 3)+">", width*0.72, height/2);
}

float drawStats(float [] input, float [] observed, boolean return_val) {
  float [] target = {input[0]+input[1], input[0]-input[1]};
  textSize(16);
  fill(255);
  float accPercent = 0;

  for (int i = 0; i < target.length; i++) {
    accPercent += accuracy(target[i], observed[i]);
  }
  if (!return_val)
    text("Error: "+ nf((accPercent)/2, 0, 2) + "%", width*0.8, height*0.52);
  return accPercent/2;
}