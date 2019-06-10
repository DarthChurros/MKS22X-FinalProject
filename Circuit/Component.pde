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
  int rot;
  
  void rotate(int r) {
    rot = r;
    
    outx = inx + 40 * size * round(cos(rot*PI/2));
    outy = iny + 40 * size * round(sin(rot*PI/2));

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
    return new int[]{min(inx-10,outx-10),min(iny-10,outy-10), Math.abs(outx - inx) + 20, Math.abs(outy - iny) + 20};
  }

  public boolean placed() {
    return isPlaced;
  }

  public void display() {
    if (toDisplay == this) {
      text("Voltage across: " + abs(voltage(a)) + " V\nCurrent through: " + current + " A", 760, 305);
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
