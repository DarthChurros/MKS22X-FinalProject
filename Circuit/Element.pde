abstract class Element{
  private boolean isPlaced = false;;
  private int x;
  private int y;
  
  
  public int getX(){
    return x;
  }
  
  public int getY(){
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
