Network myNetwork;
ArrayList<Point> nodePositions;

void setup() {
  size(1200, 800);
  background(0,0,50);
  
}

void draw() {
 nodePositions = new ArrayList<Point>();
 //drawNodes(3,2);//
 SingleHiddenLayerNetwork myNetwork = new SingleHiddenLayerNetwork(2,3,2);
 println("Initial weights");
 myNetwork.print();

 Table myData = loadTable("../backPropTraining.csv");
 train((SingleHiddenLayerNetwork)myNetwork,myData);
 drawNodesSHL(myNetwork, 50);
 drawLinksSHL(myNetwork);
// drawValue(myNetwork);

 println("Trained weights");
 myNetwork.print();
 
 float [] input = {0.7,0.4};
 float [] output = myNetwork.run(input);
 printFloats("Is this roughly <1.1,0.3>? ", output);
//(0.4,0.6)(1.0, -0.2)
 
 
 float [] input2 = {0.7,-0.3}; 
 float [] output2 = myNetwork.run(input2);
 printFloats("Is this roughly <0.4,1.0>? ", output2);
 
 
 float [] input3 = {1.4,0.2};
 float [] output3 = myNetwork.run(input3);
 printFloats("Is this roughly <1.6,1.2>? ", output3);
 //drawNodes();
 noLoop();
 //drawNodesSHL(myNetwork);
}