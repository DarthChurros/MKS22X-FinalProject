
public class Wire extends Element{
  private float voltage;
  private float vertices;
  private int inx;
  private int iny;
  private int outx;
  private int outy;

 
  //we forgot to add the in and out to the uml
  public float voltage(){
    //the most complicated method
    return voltage;
  }
  
  
  public Wire(int x1, int y1, int x2, int y2){
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
  }
  
  public float current(){
   return 0;
   //fix tomoroow
    

  }
  
  
  public void display(){
     line(inx,iny,outx,outy);

  }
  
  public boolean placed(){
    return super.placed();
  }


  
}
  
  
  
  
  
  
 
  
  
