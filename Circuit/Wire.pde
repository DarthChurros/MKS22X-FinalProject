//<<<<<<< HEAD
/*public class Wire extends Element{
  private float voltage;
  private Element in;
  private Element out;
  float x1;
  float y1;
  float x2;
  float y2;
  
  //The able will really be replaced by an arraylist of components
  
  private float x = super.getX();
  private float y = super.getY();
  
  
  public Wire(float x1, float y1, float x2, float y2){
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y3 = y2;
  }
    
    
    
 
 
  
  
  
  
  
  
 
  //we forgot to add the in and out to the uml
  //public float voltage(){
    //return in.voltage();
    //we want to sum all the voltages coming in
    //return 0.0;
  //}
  
  public float current(){
   // return in.current();
    //Later we will have to fix this and calculate current for the whole curcuit
    return 0.0;
=======
public class Wire extends Element{
  private float voltage;
  private float vertices;
  private Node in;
  private Node out;
  private float x = super.getX();
  private float y = super.getY();
 
  //we forgot to add the in and out to the uml
  public float voltage(){
    return in.voltage();
  }
  
  public float current(){
    return in.current();
    //Later we will have to fix this and calculate current for the whole curcuit
>>>>>>> master
  }
  
  
  public void display(){
<<<<<<< HEAD
    line(xi,yi,xf,yf);
=======
     line(in.xcor,in.ycor,out.xcor,out.ycor);
>>>>>>> master
  }
  
  public boolean placed(){
    return super.placed();
  }
<<<<<<< HEAD
  */
//=======
  
//>>>>>>> master

  
  
  
  
  
  
  
  
 
  
  
//<<<<<<< HEAD
//=======

//>>>>>>> master
