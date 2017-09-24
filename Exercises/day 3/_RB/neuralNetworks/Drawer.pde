ArrayList<Point> inPoints, hidPoints, outPoints; //<>// //<>// //<>//

void drawNodesSHL(SingleHiddenLayerNetwork net, int r) {
  
  //Draw input layer
  float yS = height/1/(net.inNodes.length+1); 
  float y = yS; 
  float x = width*0.25;
  inPoints = new ArrayList();
  for (int i = 0; i < net.inNodes.length; i++) {
    drawNode("a: "+net.inNodes[i].a, x, y, r); 
    inPoints.add(new Point(x, y));
    y += yS;
  }

  //Draw hidden layer
  yS = height/1/(net.hidNodes.length+1); 
  y = yS; 
  x = width*0.5;
    hidPoints = new ArrayList();

  for (int i = 0; i < net.hidNodes.length; i++) {
    drawNode("a: "+net.hidNodes[i].a, x, y, r); 
    hidPoints.add(new Point(x, y));
    y += yS;
  }

  //Draw output layer
  yS = height/1/(net.outNodes.length+1); 
  y = yS; 
  x = width*0.75;
    outPoints = new ArrayList();

  for (int i = 0; i < net.outNodes.length; i++) {
    drawNode("a: "+net.outNodes[i].a, x, y, r); 
    outPoints.add(new Point(x,y));
    y += yS;
  }
}

void drawNode(String t, float posX, float posY, int radius) {
  fill(255, 0, 255);
  text(t, posX-radius*0.5, posY-radius*0.6);
  fill(0, 255, 0);
  ellipse(posX, posY, radius, radius);
}

void drawLinksSHL(SingleHiddenLayerNetwork net) {
  //From input to hidden
  stroke(100,20,255);
  strokeWeight(4);
  for (int i = 0; i < inPoints.size(); i++)
    for (int j = 0; j < hidPoints.size(); j++) {
      line(inPoints.get(i).x, inPoints.get(i).y, hidPoints.get(j).x, hidPoints.get(j).y);
    }
  //From hidden to input
}

class Point {
  float x;
  float y;
  //int num;

  public Point(float x, float y) {
    //this.num = num;
    this.x = x;
    this.y = y;
  }

  String toString() {
    return "x: "+x+", y: "+y+ "\n";
  }
}