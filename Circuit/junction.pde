public class junction{
  //this will function as a node for the sake of nodal analysis
  public ArrayList<Element> input;
  public ArrayList<Element> output;
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
  
  public addIn(Element a){
    input.add(a);
  }
  
  
  public addOut(Element a){
    output.add(a);
  }
  
  public merge(junction b){
    
    for(int i = 0; i < b.input.size(); i++){
      input.add(b.input.get(i));
    }
    
    for(int i = 0; i < b.output.size(); i++){
      output.add(b.output.get(i));
    }
    
    b = null;
    
  }
  
  
  
  
  //type can be one of 4 things
  //base, series, open, or closed
  
  
  public void setType(String t){
    type = t;
  }
  
  
  
  
  public void display(){
    stroke(0);
    strokeWeight(1);
    fill(255);
    ellipse(x,y,10,10);
  }
  
  
}
