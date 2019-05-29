
public class Wire extends Element{
  private float voltage;
  private float vertices;
  private Node in;
  private Node out;

 
  //we forgot to add the in and out to the uml
  public float voltage(){
    return in.voltage();
  }
  
  
  public Wire(Node input, Node output){
    in = input;
    out = output;
  }
  
  public float current(){
    return in.current();
    //Later we will have to fix this and calculate current for the whole curcuit

  }
  
  
  public void display(){
     line(in.xcor,in.ycor,out.xcor,out.ycor);

  }
  
  public boolean placed(){
    return super.placed();
  }


  
}
  
  
  
  
  
  
 
  
  
