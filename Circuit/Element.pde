abstract class Element{
  private boolean isPlaced = false;;
  private float x;
  private float y;
  
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
  public boolean placed(){
    return isPlaced;
  }
  
  public void display() {
    if (!isPlaced) {
      x = mouseX;
      y = mouseY;
    }
  }
  
  public void place(){
    isPlaced = true;
    
  }
  
  abstract public float current();
  
  
  abstract public float voltage();
  
  
  

  
}
