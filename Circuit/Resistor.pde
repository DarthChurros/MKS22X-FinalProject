public class Resistor extends Component{
  Node input;
  Node output;
  double resist;
  //Everything is based off of the Node
  
  public Resistor(Node in, Node out, double value){
    input = in;
    output = out;
    resist =  value;
    type = "Resistor";
  }
  
  public void display(){
    //OK, now this is the hard part, we first need to figure out but im going to do a red line for now
    line(input.xcor, input.ycor, output.xcor, output.ycor);
    fill(255,0,0);
  }
  
  
  public float voltage(){
    //need to do a calculation
    return 0.0;
  }
  
  
  public float current(){
    //need to do a calculation
    return 0.0;
  }
  
  
}
