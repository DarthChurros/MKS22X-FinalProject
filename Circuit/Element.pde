abstract class Element{
  boolean isPlaced = false;
  float x;
  float y;
  public int inx;
  public int iny;
  
  public void rotate(){
  }
  
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
  
  abstract void shift(int x1, int y1, int x2, int y2);
  
  abstract public float current();
  
  
  abstract public float voltage();
  
  
  

  
}
