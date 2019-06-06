
public class VoltSource extends Component {
  boolean rot = false;
  float voltage;
  //Everything is based off of the Node
  
  public void rotate(){
    rot = !rot;
    if(rot){
      outx = inx;
      outy = iny + 80;
    } else {
      outx = inx + 80;
      outy = iny;
    }
    b.x = outx;
    b.y = outy;
  }
  
  public VoltSource(int x1, int y1, int x2, int y2, float value){
    isSource = true;
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
    voltage =  value;
    
    a = new junction(inx, iny);
    a.add(this);
    b = new junction(outx, outy);
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




  public float voltage() {
    return voltage;
  }


  public float current() {
    return 0.0;
    //need to calculate the total resistance in order to do this
  }
}
