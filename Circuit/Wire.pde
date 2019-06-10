
class Wire extends Component {
  float voltage;


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
  
  
  public int[] hitBox(){
    return new int[]{inx - 10 , iny - 10, Math.abs(outx - inx) + 20 , Math.abs(outy - iny) + 20};
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


  public Wire(int x1, int y1, int x2, int y2) {
    inx = x1;
    iny = y1;
    outx = x2;
    outy = y2;
    size = 1;
    a = new Junction(inx, iny);
    b = new Junction(outx, outy);
    a.add(this);
    b.add(this);
  }

  public float current() {
    return 0;
    //fix tomoroow
  }


  public void display() {
    super.display();
    
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
