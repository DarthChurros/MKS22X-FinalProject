abstract class Element {
  boolean isPlaced = false;
  float x;
  float y;
  int inx;
  int iny;
  int outx;
  int outy;
  int size;
  junction a;
  junction b;
  boolean rot;
  
  void rotate() {
    rot = !rot;
    if(rot){
      outx = inx;
      outy = iny + 40 * size;
    } else {
      outx = inx + 40 * size;
      outy = iny;
    }
    b.x = outx;
    b.y = outy;
  }
  
  public float getX(){
    return x;
  }

  public float getY() {
    return y;
  }





  public boolean placed() {
    return isPlaced;
  }

  public void display() {
    if (!isPlaced) {
      x = mouseX;
      y = mouseY;
    }
  }

  public void place() {
    isPlaced = true;
  }

  abstract void shift(int x1, int y1, int x2, int y2);

  abstract public float current();


  abstract public float voltage();
}
