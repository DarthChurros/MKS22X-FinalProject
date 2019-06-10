
public class VoltSource extends Component {
  float voltage;
  //Everything is based off of the Node
  
  public VoltSource(int x1, int y1, int x2, int y2, float value){
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
    size = 2;
    voltage =  value;
    
    a = new Junction(inx, iny);
    a.add(this);
    b = new Junction(outx, outy);
    b.add(this);
    //were gonna have the ground just equal to 0, so now we have
    //this is gonna just be the default, we can fix this later
    //input.setVoltage(0.0);
    //this last part we can obviously keep
    //adding more than one voltsource is gonna be hard
    //output.setVoltage(input.voltage() + voltage);
  }

  public void shift(int x1, int y1, int x2, int y2) {
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
  }
  
  
  
  public int[] hitBox(){
    return new int[]{inx - 10 , iny - 10, Math.abs(outx - inx) + 20 , Math.abs(outy - iny) + 20};
  }
  
  public String deleteCheck(){
    String ans = "";
    //checks the junctions to see if the junctions are merged, and if they are dont delete them
    if(a.terminals.size() == 1){
      ans += "a";
    }
    if(b.terminals.size() == 1){
      ans += "b";
    }
    return ans;
  }

  /*public boolean addWire(Wire w, int x, int y) {
    if (x == inx && y == iny) {
      input = w;
      a.addIn(w);
      return true;
    }
    if (x == outx && y == outy) {
      output = w;
      b.addOut(w);
      return true;
    }
    return false;
  } */

  public void display() {
    //OK, now this is the hard part, we first need to figure out but im going to do a green line for now
    //
    super.display();
    
    if(!rot){
    strokeWeight(4);
    stroke(0,255,0);
    line(inx, iny, inx + 30, iny);
    //line to the left^^


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

     a.display();
     b.display();
     
    } else {

    strokeWeight(4);
    stroke(0,255,0);
    line(inx, iny, inx, iny+30);

    strokeWeight(4);
    stroke(0,255,0);
    line(inx - 20, iny + 20, inx + 20, iny+20);

    strokeWeight(4);
    stroke(0,255,0);
    line(inx - 30, iny + 50, inx + 30, iny+50);

    strokeWeight(4);
    stroke(0,255,0);
    line(inx, iny + 50, inx, iny+80);

    a.display();
    b.display();

    }
  }

}
