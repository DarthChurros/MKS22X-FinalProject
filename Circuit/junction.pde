public class junction{
  //this will function as a node for the sake of nodal analysis
  public ArrayList<Element> terminals;
  public String type;
  public int x;
  public int y;
  public float relativeVoltage;
  public float relativeCurrent;

  public junction(int c, int d){
    terminals = new ArrayList<Element>();
    x = c;
    y = d;
  }
  
  public void add(Element a){
    terminals.add(a);
  }
  
  public boolean voltsOut(){
    for(int i = 0; i < terminals.size(); i++){
      if(terminals.get(i) instanceof VoltSource && terminals.get(i).output == this) return true;
    }
    return false;
    
  }
  
 
  
  public void merge(junction b){
    
    for(int i = 0; i < b.terminals.size(); i++){
      terminals.add(b.terminals.get(i));
    }
    
    b = null;
    
  }
  
  
  
  
  //type can be one of 4 things
  //base, series, open, or closed
  
  
  public void setType(String t){
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
  
  
  public void display(){
    stroke(0);
    strokeWeight(1);
    fill(255);
    ellipse(x,y,10,10);
  }
  
  
}
