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

float accuracy(float target, float observed){
  return abs((target - observed)/target * 100);
}

class Point {
  float x;
  float y;

  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }

  String toString() {
    return "x: "+x+", y: "+y+ "\n";
  }
}

public Point PointOnLine(float x1, float y1, float x2, float y2, float offset)
{
  //Returns a coordinate at offset distance away from x1,y1 towards x2,y2
  float distance = (float)sqrt(pow((x2 - x1), 2) + pow((y2 - y1), 2));
  float ratio = offset / distance;

  float x3 = ratio * x2 + (1 - ratio) * x1;
  float y3 = ratio * y2 + (1 - ratio) * y1;
  return new Point(x3, y3);
}

void printFloats(String init, float[] in, float [] a) {
  String s=init+"<"+nf(in[1]+in[0], 0, 2)+", "+nf(in[1]-in[0], 0, 2)+">?"; 
  for (int i=0; i<a.length; i++) s+= " " + nf(a[i], 0, 2); 
  println(s);
}