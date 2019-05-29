public class Node extends Element{
  ArrayList<Element> inputs = new ArrayList<Element>();
  ArrayList<Element> outputs = new ArrayList<Element>();
  public int xcor;
  public int ycor;
  float voltageIn;
  boolean placed = false;
  public Node(int x, int y, ArrayList<Element> input, ArrayList<Element> output){
    inputs = input;
    outputs = output;
    xcor = x;
    ycor = y;
  }
  
  public Node(int x, int y, Element input, Element output){
    inputs.add(input);
    outputs.add(output);
    xcor = x;
    ycor = y;
  }
  
  public Node(int x, int y){
    inputs = new ArrayList<Element>();
    outputs = new ArrayList<Element>();
    xcor = x;
    ycor = y;
  }
  
  //Constructors above
  //Now were gonna do the display commands
  
  
  public void display(){
    ellipse(x,y,30,30);
    fill(255);
  }
  
  
   public float setVoltage(float value){
    voltageIn = value;
    return value;
  }
  
  
  public float voltage(){
    return voltageIn;
  }
  
  
  public float current(){
    return 0.0;
  }
  
  
  
  
  
  
  
  //A node must be associated with atleast 2 values
  
  
  
}
