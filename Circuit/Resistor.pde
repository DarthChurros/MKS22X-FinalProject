public class Resistor extends Component{
  int inx;
  int iny;
  int outx;
  int outy;
  ArrayList<Wire> input = new ArrayList<Wire>();
  ArrayList<Wire> output = new ArrayList<Wire>();
  float resist;
  float current;
  //Everything is based off of the Node
  
  public Resistor(int x1, int y1, int x2, int y2, float value){
    vToI = new Function("x " + value + " /");
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
    type = "Resistor";
  }
  
  
  public boolean addWire(Wire w, int x, int y){
    if (x == inx && y == iny) {
      input.add(w);
      return true;
    }
    if (x == outx && y == outy) {
      output.add(w);
      return true;
    }
    return false;
    
  }
  
  public void display(){
    //OK, now this is the hard part, we first need to figure out but im going to do a red line for now
    line(inx, iny, inx, iny);
    stroke(255,0,0);
  }
  
  
  public float voltage(){
    if(output.size() == 0 || input.size() == 0) return 0;
   return abs(output.get(0).voltage() - input.get(0).voltage());
  }
  
 
}