public class VoltSource extends Component{
  Node input;
  Node output;
  float voltage;
  //Everything is based off of the Node
  
  public VoltSource(Node in, Node out, float value){
    input = in;
    output = out;
    voltage =  value;
    type = "VoltSource";
    //were gonna have the ground just equal to 0, so now we have
    //this is gonna just be the default, we can fix this later
    input.setVoltage(0.0);
    //this last part we can obviously keep
    //adding more than one voltsource is gonna be hard
    output.setVoltage(input.voltage() + voltage);
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
