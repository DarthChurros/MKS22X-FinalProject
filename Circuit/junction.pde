import java.util.NoSuchElementException;

class Junction {
  //this will function as a node for the sake of nodal analysis
  ArrayList<Component> terminals;
  String type;
  int x;
  int y;
  float relativeVoltage;
  float relativeCurrent;

  public Junction(int c, int d) {
    terminals = new ArrayList<Component>();
    x = c;
    y = d;
  }

  public void add(Component a) {
    terminals.add(a);
  }

  public boolean voltsOut() {
    for (int i = 0; i < terminals.size(); i++) {
      if (terminals.get(i) instanceof VoltSource && terminals.get(i).a == this) return true;
    }
    return false;
  }



  public void merge(Junction b) {

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

  ArrayList<Junction> getNode() {
    //ArrayList<Junction> node = new ArrayList<Junction>();
    //getNodeH(node);
    //return node;
    for (ArrayList<Junction> node : nodes) {
      if (node.contains(this)) return node;
    }
    return null;
  }

  void getNodeH(ArrayList<Junction> current) {
    if (!current.contains(this)) {
      current.add(this);
      return;
    }
    for (Component e : terminals) {
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
    ArrayList<Junction> node = getNode();
    ArrayList<Component> components = new ArrayList<Component>();

    for (Junction j : node) {
      for (Component e : j.terminals) {
        if (e instanceof Component) components.add((Component)e);
      }
    }
    return components;
  }
  
  float[] relations() {
    ArrayList<Component> components = adjacent();
    
    float[] row = new float[nodes.size()+1];
    for (Component c : components) {
      for (int i = 0; i < nodes.size(); i++) {
        if (nodes.get(i).contains(c.a) && c.b == this
        || nodes.get(i).contains(c.b) && c.a == this) {
          if (c instanceof VoltSource) {
            row = new float[nodes.size()+1];
            row[i] = -1;
            row[row.length-1] = ((VoltSource)c).voltage;
            if (c.a == this) row[row.length-1] *= -1;
            for (int j = 0; j < nodes.size(); j++) {
              if (nodes.get(j).contains(this)) {
                row[j] = 1;
                return row;
              }
            }
            throw new NoSuchElementException("This node wasn't found!");
          }
          if (c instanceof Resistor) {
            row[i] = -1 / ((Resistor)c).resistance;
          }
        }
      }
    }

    for (int i = 0; i < nodes.size(); i++) {
      if (nodes.get(i).contains(this)) {
        row[i] = 0;
        for (int j = 0; j < row.length; j++) {
          if (j != i) row[i] -= row[j];
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
    String ans = "Junction linking:\n";
    for (Component e : terminals) {
      ans += e+"\n";
    }
    return ans;
  }
}
