class Node {
  Link [] linksIn; // perhaps null
  Link [] linksOut; // perhaps null
  float in;    // -- not relevant for input nodes
  float a;     // -- for input nodes: the given input; for all others: computed value
  float delta; // -- not relevant for input nodes

  Node() {
    linksIn = new Link[0]; 
    linksOut = new Link[0];
  }

  void eval() { // should not be called on input nodes
    in=0; 
    for (int i=0; i<linksIn.length; i++) 
      in+= linksIn[i].from.a*linksIn[i].weight;
    a = sigmoid(in);
  }
}

class Link {
  float weight;
  Node from;
  Node to;

  Link(Node f, Node t) {
    from=f; 
    to=t; 
    weight=random(-1, 1);
    from.linksOut = add(from.linksOut, this);
    to.linksIn    = add(to.linksIn, this);
  }
}

/////// a helper
Link [] add(Link [] oldLinks, Link extra) {
  Link [] newLinks = new Link[oldLinks.length+1];
  for (int i=0; i<oldLinks.length; i++) newLinks[i]=oldLinks[i];
  newLinks[oldLinks.length] = extra;
  return newLinks;
}