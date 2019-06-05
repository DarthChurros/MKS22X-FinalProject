public class junction {
  //this will function as a node for the sake of nodal analysis
  public ArrayList<Element> terminals;
  public String type;
  public int x;
  public int y;
  public float relativeVoltage;
  public float relativeCurrent;

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
    }

    b = null;
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
    }
    for (Element e : terminals) {
      if (e instanceof Wire) {
        if (((Wire)e).a == this) {
          ((Wire)e).b.getNodeH(current);
        } else {
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
  
  float[] relations(ArrayList<ArrayList<junction>> circuit) {
    ArrayList<Component> components = adjacent();

    float[] row = new float[circuit.size()];
    for (Component c : components) {
      for (int i = 0; i < circuit.size(); i++) {
        if (circuit.get(i).contains(c.in())) {
          row[i] = -1 / ((Resistor)c).resistance();
          if (c.out() == this && c.isSource()) {
            row[i] = ((VoltSource)c).voltage();
          }
        }
        if (circuit.get(i).contains(c.out())) {
          row[i] = -1 / ((Resistor)c).resistance();
          if (c.in() == this && c.isSource()) {
            row[i] = -1 * ((VoltSource)c).voltage();
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
}
