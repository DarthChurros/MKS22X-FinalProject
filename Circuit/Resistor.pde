public class Resistor extends Component{
  Node input;
  Node output;
  float resist;
  float current;
  //Everything is based off of the Node
  
  public Resistor(Node in, Node out, float value){
    vToI = new Function("x " + value + " /");
    input = in;
    output = out;
    type = "Resistor";
  }
  
  public void display(){
    //OK, now this is the hard part, we first need to figure out but im going to do a red line for now
    line(input.xcor, input.ycor, output.xcor, output.ycor);
    fill(255,0,0);
  }
  
  
  public float voltage(){
   return abs(output.voltage() - input.voltage());
  }
}
