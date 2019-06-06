class junction {
  //this will function as a node for the sake of nodal analysis
  ArrayList<Element> terminals;
  String type;
  int x;
  int y;
  float relativeVoltage;
  float relativeCurrent;

  public junction(int c, int d) {
    terminals = new ArrayList<Element>();
    x = c;
    y = d;
  }

  public void add(Element a) {
    terminals.add(a);
  }

  public boolean voltsOut() {
    for (int i = 0; i < terminals.size(); i++) {
      if (terminals.get(i) instanceof VoltSource && terminals.get(i).a == this) return true;
    }
    return false;
  }



  public void merge(junction b) {

    for (int i = 0; i < b.terminals.size(); i++) {
      terminals.add(b.terminals.get(i));
      if (b.terminals.get(i).a == b) {
        b.terminals.get(i).a = this;
      }
      if (b.terminals.get(i).b == b) {
        b.terminals.get(i).b = this;
      }
    }
  b.terminals = null;
  }




  //type can be one of 4 things
  //base, series, open, or closed


  public void setType(String t) {
    type = t;
  }

  ArrayList<junction> getNode() {
    ArrayList<junction> node = new ArrayList<junction>();
    getNodeH(node);
    return node;
  }

  void getNodeH(ArrayList<junction> current) {
    if (!current.contains(this)) {
      current.add(this);
      return;
    }
    for (Element e : terminals) {
      if (e instanceof Wire) {
        if (((Wire)e).a == this) {
          ((Wire)e).b.getNodeH(current);
        } else if (((Wire)e).b == this) {
          ((Wire)e).a.getNodeH(current);
        }
      }
    }
  }

  ArrayList<Component> adjacent() {
    ArrayList<junction> node = getNode();
    ArrayList<Component> components = new ArrayList<Component>();

    for (junction j : node) {
      for (Element e : j.terminals) {
        if (e instanceof Component) components.add((Component)e);
      }
    }
    return components;
  }
  
  float[] relations() {
    ArrayList<Component> components = adjacent();

    float[] row = new float[nodes.size()];
    for (Component c : components) {
      for (int i = 0; i < nodes.size(); i++) {
        if (nodes.get(i).contains(c.a)) {
          if (c.b == this && c.isSource()) {
            row[i] = ((VoltSource)c).voltage();
          } else {
            row[i] = -1 / ((Resistor)c).resistance();
          }
        }
        if (nodes.get(i).contains(c.b)) {
          if (c.a == this && c.isSource()) {
            row[i] = -1 * ((VoltSource)c).voltage();
          } else {
            row[i] = -1 / ((Resistor)c).resistance();
          }
        }
      }
    }

    for (int i = 0; i < circuit.size(); i++) {
      if (circuit.get(i).contains(this)) {
        row[i] = 0;
        for (int j = 0; j < row.length; j++) {
          row[i] -= row[j];
        }
        return row;
      }
    }
    return null;
  }


  public void display() {
    stroke(0);
    strokeWeight(1);
    fill(255);
    ellipse(x, y, 10, 10);
  }
  
  String toString() {
    String ans = "junction linking:\n";
    for (Element e : terminals) {
      ans += e+"\n";
    }
    return ans;
  }
}
