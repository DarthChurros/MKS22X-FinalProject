
public class Wire extends Element{
  private float voltage;
  private float vertices;
  private int inx;
  private int iny;
  private int outx;
  private int outy;
  Element in;
  Element out;

 
  //we forgot to add the in and out to the uml
  public float voltage(){
    //the most complicated method
    return voltage;
  }
  
  
  public void shift(int x1,  int y1, int x2, int y2){
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
  }
  
  
  public Wire(int x1, int y1, int x2, int y2){
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
  }
  
  public float current(){
   return 0;
   //fix tomoroow
    

  }
  
  
  public void display(){
     line(inx,iny,outx,outy);
     stroke(0,0,0);

  }
  
  public boolean placed(){
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
  
  
  
  
  
  
 
  
  
