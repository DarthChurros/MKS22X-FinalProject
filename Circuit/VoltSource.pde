public class VoltSource extends Component{
  int inx;
  int iny;
  int outx;
  int outy;
  boolean rot = false;
  float voltage;
  ArrayList<Wire> input = new ArrayList<Wire>();
  ArrayList<Wire> output = new ArrayList<Wire>();
  //Everything is based off of the Node
  
  
  public void rotate(){
    rot = !rot;
  }
  public VoltSource(int x1, int y1, int x2, int y2, float value){
    isSource = true;
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
    voltage =  value;
    type = "VoltSource";
    //were gonna have the ground just equal to 0, so now we have
    //this is gonna just be the default, we can fix this later
    //input.setVoltage(0.0);
    //this last part we can obviously keep
    //adding more than one voltsource is gonna be hard
    //output.setVoltage(input.voltage() + voltage);
  }
  
  public void shift(int x1,  int y1, int x2, int y2){
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
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
    //OK, now this is the hard part, we first need to figure out but im going to do a green line for now
    //
    
    if(!rot){
    strokeWeight(4);
    stroke(0,255,0);
    line(inx, iny, inx + 30, iny);
    //line to the left^^
    
    stroke(0,0,0);
    strokeWeight(1);
    fill(255,255,255);
    ellipse(inx, iny, 10, 10);
    
    strokeWeight(4);
    stroke(0,255,0);
    line(inx+30, iny + 20, inx + 30, iny - 20);
    //first line (smaller)
    
    
    strokeWeight(4);
    stroke(0,255,0);
    line(inx+50, iny +30 , inx +50, iny - 30);
    //second line (bigger)
    
    
    strokeWeight(4);
    stroke(0,255,0);
    line(inx+50, iny, inx + 80, iny);
    //line to the left^^
    
    stroke(0,0,0);
    strokeWeight(1);
    fill(255,255,255);
    ellipse(inx +80, iny, 10, 10);
    
    } else {
      
    strokeWeight(4);
    stroke(0,255,0);
    line(inx, iny, inx, iny+80);
    }
    
  }
  
  
 
  
  public float voltage(){
    
    return voltage;
  }
  
  
  public float current(){
    return 0.0;
    //need to calculate the total resistance in order to do this
  }
  
  
}
