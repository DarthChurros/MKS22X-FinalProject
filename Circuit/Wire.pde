
class Wire extends Element {
  float voltage;
  int inx;
  int iny;
  int outx;
  int outy;
 


  boolean rot = false;

  public void rotate() {
    rot = !rot;
    if(rot){
      outx = inx;
      outy = iny + 40;
    } else {
      outx = inx + 40;
      outy = iny;
    }
    b.x = outx;
    b.y = outy;
  }
  //we forgot to add the in and out to the uml
  public float voltage() {
    //the most complicated method
    return voltage;
  }


  public void shift(int x1, int y1, int x2, int y2) {
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
  }


  public Wire(int x1, int y1, int x2, int y2) {
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
    a = new junction(inx, iny);
    b = new junction(outx, outy);
    a.add(this);
    b.add(this);
  }

  public float current() {
    return 0;
    //fix tomoroow
  }


  public void display() {
    if (!rot) {
      
      
      stroke(255);
      strokeWeight(4);
      line(inx, iny, inx + 40, iny);


      a.display();
      b.display();
      
      
    } else {
      stroke(255, 255, 255);
      strokeWeight(4);
      line(inx, iny, inx, iny + 40);

      a.display();
      b.display();
    }
  }




  public boolean placed() {
    return super.placed();
  }
}
