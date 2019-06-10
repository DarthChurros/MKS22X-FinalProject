public class Resistor extends Component {
  public float resistance;
  //Everything is based off of the Node

  //i used to think these would be in and out but current can flow through both ways depending on the circuit
  
  public Resistor(int x1, int y1, int x2, int y2, float value) {
    resistance = value;
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
    size = 2;
    a = new Junction(inx, iny);
    a.add(this);
    b = new Junction(outx, outy);
    b.add(this);
  }

  
  float resistance() {
    return resistance;
  }

  public void shift(int x1, int y1, int x2, int y2) {
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
  }

  /*public boolean setWire(Wire w, int x, int y) {
    if (x == inx && y == iny) {
       input = w;
      return true;
    }
    if (x == outx && y == outy) {
      output = w;
      return true;
    }
    return false;
  }*/
  


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
  
  
  public void display() {
    //OK, now this is the hard part, we first need to figure out but im going to do a red line for now
    super.display();
    if (toDisplay == this) {
      text("\n\nResistance: "+resistance+" Ω", 760, 305);
    }
    stroke(255, 0, 0);
    strokeWeight(4);
    line(inx, iny, inx + 15*round(cos(rot*PI/2)), iny+15*round(sin(rot*PI/2)));


    stroke(255, 0, 0);
    strokeWeight(4);
    line(inx + 15*round(cos(rot*PI/2)), iny+15*round(sin(rot*PI/2)), inx + 20*round(cos(rot*PI/2))+20*round(sin(rot*PI/2)), iny+20*round(sin(rot*PI/2))+20*round(cos(rot*PI/2)));

    stroke(255, 0, 0);
    strokeWeight(4);
    line(inx + 20*round(cos(rot*PI/2))+20*round(sin(rot*PI/2)), iny + 20*round(sin(rot*PI/2))+20*round(cos(rot*PI/2)), inx + 30*round(cos(rot*PI/2))-20*round(sin(rot*PI/2)), iny-20*round(cos(rot*PI/2))+30*round(sin(rot*PI/2)));

    stroke(255, 0, 0);
    strokeWeight(4);
    line(inx + 30*round(cos(rot*PI/2))-20*round(sin(rot*PI/2)), iny - 20*round(cos(rot*PI/2))+30*round(sin(rot*PI/2)), inx + 40*round(cos(rot*PI/2))+20*round(sin(rot*PI/2)), iny + 20*round(cos(rot*PI/2))+40*round(sin(rot*PI/2)));

    stroke(255, 0, 0);
    strokeWeight(4);
    line(inx + 40*round(cos(rot*PI/2))+20*round(sin(rot*PI/2)), iny + 20*round(cos(rot*PI/2))+40*round(sin(rot*PI/2)), inx + 50*round(cos(rot*PI/2))-20*round(sin(rot*PI/2)), iny - 20*round(cos(rot*PI/2))+50*round(sin(rot*PI/2)));

    stroke(255, 0, 0);
    strokeWeight(4);
    line(inx + 50*round(cos(rot*PI/2))-20*round(sin(rot*PI/2)), iny - 20*round(cos(rot*PI/2))+50*round(sin(rot*PI/2)), inx + 60*round(cos(rot*PI/2))+20*round(sin(rot*PI/2)), iny + 20*round(cos(rot*PI/2))+60*round(sin(rot*PI/2)));

    stroke(255, 0, 0);
    strokeWeight(4);
    line(inx + 60*round(cos(rot*PI/2))+20*round(sin(rot*PI/2)), iny + 20*round(cos(rot*PI/2))+60*round(sin(rot*PI/2)), inx + 65*round(cos(rot*PI/2)), iny+65*round(sin(rot*PI/2)));

    stroke(255, 0, 0);
    strokeWeight(4);
    line(inx + 65*round(cos(rot*PI/2)), iny+65*round(sin(rot*PI/2)), inx + 80*round(cos(rot*PI/2)), iny+80*round(sin(rot*PI/2)));

    stroke(0, 0, 0);
    strokeWeight(1);
    fill(255, 255, 255);
    ellipse(inx, iny, 10, 10);
    
    a.display();
    b.display();
  }
}
