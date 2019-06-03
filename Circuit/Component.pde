abstract class Component extends Element{
  boolean isSource = false;
  String type;
  int inx;
  int iny;
  int outx;
  int outy;
  ArrayList<Wire> input = new ArrayList<Wire>();
  ArrayList<Wire> output = new ArrayList<Wire>();
   
   
   
  
   // the default will just focus like a regular wire until given further specifications
  
   
   
   public String whatType(){
     return type;
   }
  
  void rotate() {
    
  }
}
