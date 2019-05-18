void setup(){
}
abstract class Element{
  private boolean isPlaced = false;;
  private double x;
  private double y;
  
  
  public double getX(){
    return x;
  }
  
  public double getY(){
    return y;
  }
  
  public boolean placed(){
    return isPlaced;
  }
  
  abstract public void place();
  
  
  abstract public double current();
  
  
  abstract public double voltage();
  
  
  

  
}
