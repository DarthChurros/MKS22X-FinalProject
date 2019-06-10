abstract class Component {
  boolean isPlaced = false;
  float x;
  float y;
  int inx;
  int iny;
  int outx;
  int outy;
  int size;
  float current;
  Junction a;
  Junction b;
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


  float voltage(Junction ref) {
    if (ref != a && ref != b) throw new IllegalArgumentException("given junction must be a terminal");
    float v = abs(a.relativeVoltage - b.relativeVoltage);
    if (ref == a) v *= -1;
    return v;
  }
}
