public class junction{
  //this will function as a node for the sake of nodal analysis
  ArrayList<Element> input;
  ArrayList<Element> output;
  String type;
  int x;
  int y;
  float relativeVoltage;
  float relativeCurrent;
  
  public junction(int c, int d){
    type = "series";
    x = c;
    y = d;
  }
  
  public junction(int c, int d, String typ){
    type = typ;
    x = c;
    y = d;
  }
  
  //type can be one of 4 things
  //base, series, open, or closed
  
  
  public void setType(String t){
    type = t;
  }
  
  
  
  
  public void diplay(){
    stroke(255,255,255);
    strokeWeight(1);
    ellipse(x,y,10,10);
  }
}
