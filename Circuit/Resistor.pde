public class Resistor extends Component {
  float resistance;
  boolean rot = false;
  //Everything is based off of the Node
  public junction a;
  public junction b;

  //i used to think these would be in and out but current can flow through both ways depending on the circuit
  
  public Resistor(int x1, int y1, int x2, int y2, float value) {
    resistance = value;
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
    a = new junction(inx, iny);
    b = new junction(outx, outy);
  }


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
  
  float resistance() {
    return resistance;
  }

  public void shift(int x1, int y1, int x2, int y2) {
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
  }

  public boolean setWire(Wire w, int x, int y) {
    if (x == inx && y == iny) {
      input = w;
      return true;
    }
    if (x == outx && y == outy) {
      output = w;
      return true;
    }
    return false;
  }

  public void display() {
    //OK, now this is the hard part, we first need to figure out but im going to do a red line for now
    if (!rot) {
      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx, iny, inx + 15, iny);


      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx + 15, iny, inx + 20, iny+20);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx + 20, iny + 20, inx + 30, iny-20);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx + 30, iny - 20, inx + 40, iny + 20);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx + 40, iny + 20, inx + 50, iny - 20);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx + 50, iny - 20, inx + 60, iny + 20);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx + 60, iny + 20, inx + 65, iny);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx + 65, iny, inx + 80, iny);

      stroke(0, 0, 0);
      strokeWeight(1);
      fill(255, 255, 255);
      ellipse(inx, iny, 10, 10);
      
      
      a.display();
      b.display();
    } else {

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx, iny, inx, iny+ 15);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx, iny+15, inx + 20, iny+ 20);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx+20, iny+20, inx - 20, iny+ 30);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx-20, iny+30, inx + 20, iny+ 40);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx+20, iny+40, inx-20, iny+ 50);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx-20, iny+50, inx+20, iny+60);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx+20, iny+60, inx, iny+65);

      stroke(255, 0, 0);
      strokeWeight(4);
      line(inx, iny+65, inx, iny+80);

      stroke(0, 0, 0);
      strokeWeight(1);
      fill(255, 255, 255);
      ellipse(inx, iny, 10, 10);

      stroke(0, 0, 0);
      strokeWeight(1);
      fill(255, 255, 255);
      ellipse(inx, iny + 80, 10, 10);
    }
  }




  public float voltage() {
    if (output == null || input == null) return 0;
    return abs(output.voltage() - input.voltage());
  }

  public float current() {
    return voltage() / resistance;
  }
}
