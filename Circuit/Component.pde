abstract class Component {
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

  int[] hitBox(){
    return new int[]{1,2,3,4};
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

  public String deleteCheck(){
    String ans = "";
    //checks the junctions to see if the junctions are merged, and if they are dont delete them
    if(a.terminals.size() == 1){
      ans += "a";
    }
    if(b.terminals.size() == 1){
      ans += "b";
    }
    return ans;
  }

  public void place() {
    isPlaced = true;
  }

  abstract void shift(int x1, int y1, int x2, int y2);

  abstract public float current();


  abstract public float voltage();
}
