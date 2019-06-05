
public class Wire extends Element {
  private float voltage;
  private int inx;
  private int iny;
  private int outx;
  private int outy;
  Element in;
  Element out;
  public junction a;
  public junction b;
 


  boolean rot = false;

  public void rotate() {
    rot = !rot;
    if(rot){
      outx = inx;
      outy = iny + 80;
      b = new junction(outx, outy);
      
    } else {
      outx = inx + 80;
      outy = iny;
      b = new junction(outx, outy);
    }
  }
  //we forgot to add the in and out to the uml
  public float voltage() {
    //the most complicated method
    return voltage;
  }


  public void shift(int x1, int y1, int x2, int y2) {
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
  }


  public Wire(int x1, int y1, int x2, int y2) {
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
  }

  public float current() {
    return 0;
    //fix tomoroow
  }

  float[] relations(ArrayList<ArrayList<Wire>> circuit) {
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

  ArrayList<Component> adjacent() {
    ArrayList<Wire> node = getNode();
    ArrayList<Component> components = new ArrayList<Component>();

   for (Wire w : node) {
      if (w.in instanceof Component) components.add((Component)w.in);
      if (w.out instanceof Component) components.add((Component)w.out);
    }

    return components;
  }


  public void display() {
    if (!rot) {
      stroke(255, 255, 255);
      strokeWeight(4);
      line(inx, iny, inx + 40, iny);


      stroke(0, 0, 0);
      strokeWeight(1);
      fill(255, 255, 255);
      ellipse(inx, iny, 10, 10);

      stroke(0, 0, 0);
      strokeWeight(1);
      fill(255, 255, 255);
      ellipse(inx +40, iny, 10, 10);
    } else {
      stroke(255, 255, 255);
      strokeWeight(4);
      line(inx, iny, inx, iny + 40);

      stroke(0, 0, 0);
      strokeWeight(1);
      fill(255, 255, 255);
      ellipse(inx, iny, 10, 10);

      stroke(0, 0, 0);
      strokeWeight(1);
      fill(255, 255, 255);
      ellipse(inx, iny + 40, 10, 10);
    }
  }




  public boolean placed() {
    return super.placed();
  }

  ArrayList<Wire> getNode() {
    ArrayList<Wire> node = new ArrayList<Wire>();
    getNodeH(node);
    return node;
  }

  void getNodeH(ArrayList<Wire> current) {
    if (!current.contains(this)) {
      current.add(this);
      if (in instanceof Wire) {
        Wire inWire = (Wire)in;
        inWire.getNodeH(current);
      }
      if (out instanceof Wire) {
        Wire outWire = (Wire)out;
        outWire.getNodeH(current);
      }
    }
  }
}
