public class VoltSource extends Component{
  Node input;
  Node output;
  double voltage;
  //Everything is based off of the Node
  
  public VoltSource(Node in, Node out, double value){
    input = in;
    output = out;
    voltage =  value;
    type = "VoltSource";
  }
  
  public void display(){
    //OK, now this is the hard part, we first need to figure out but im going to do a red line for now
    line(input.xcor, input.ycor, output.xcor, output.ycor);
    fill(0,255,0);
  }
  
  public float voltage(){
    return input.voltageIn;
  }
  
  
  public float current(){
    return 0.0;
  }
  
  
}
