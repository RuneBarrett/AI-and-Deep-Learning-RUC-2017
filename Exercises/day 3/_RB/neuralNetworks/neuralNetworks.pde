SingleHiddenLayerNetwork myNetwork;
PFont myFont;
boolean train = true;
boolean draw = true;
boolean weightColors = false;
float [] input = {0.7, 1.2};
float [] output;
String statStr = "";
String boxStr = "";
String info = "Hover over a node to see information about it.";

void setup() {
  size(1400, 1000);
  //fullScreen();
  myFont = loadFont("AGaramondPro-Bold-48.vlw");
  textFont(myFont);
  background(0, 0, 50);
  textSize(50);
  text("Learning...", width*0.4, height*0.5);
}

void draw() {
  mouseHover();
  if (train) {
    text("Learning...", width*0.4, height*0.5);
    myNetwork = new SingleHiddenLayerNetwork(2, 4, 2);
    println("Initial weights");
    myNetwork.print();

    Table myData = loadTable("../backPropTraining.csv");
    train((SingleHiddenLayerNetwork)myNetwork, myData);

    /* Draw trained network */
    //drawNodesSHL(myNetwork, 50);
    //drawLinksSHL(myNetwork, 26);

    println("Trained weights");
    myNetwork.print();
    //test();

    train = false;
    netUpdate();
    //draw = true;
  }
  /*if (draw) {
   netUpdate();
   draw = false;
   }*/
}

void netUpdate() {
  background(0, 0, 70);
  output = myNetwork.run(input);
  //printFloats("Is this roughly ", input, output);
  drawNodesSHL(myNetwork, 40);
  drawLinksSHL(myNetwork, 26);
  drawInputOutput(input, output);
  buttons();
  drawStats(input, output, false);
  text(statStr, width*0.05, height*0.86);
  textSize(30);
  text(info, width*0.3, height*0.1);
  //println(sigmoid(-0.682*0.3520+0.2986*0.5034));
}

void test() {

  float [] input = {0.7, 0.4};
  output = myNetwork.run(input);
  printFloats("Is this roughly ", input, output);

  float [] input2 = {0.7, -0.3}; 
  float [] output2 = myNetwork.run(input2);
  printFloats("Is this roughly ", input2, output2);

  float [] input3 = {1.2, 0.5};
  float [] output3 = myNetwork.run(input3);
  printFloats("Is this roughly ", input3, output3);

  float [] input4 = {0.2, -0.5};
  float [] output4 = myNetwork.run(input4);
  printFloats("Is this roughly ", input4, output4);
}