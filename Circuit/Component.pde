abstract class Component extends Element{
  boolean isSource = false;
  String type;
  int inx;
  int iny;
  int outx;
  int outy;
  Wire input;
  Wire output;
   
   
   
  
   // the default will just focus like a regular wire until given further specifications
  
   
   
   public String whatType(){
     return type;
   }
  
  void rotate() {
    
  }
  
  Wire in() {
    return input;
  }
  
  Wire out() {
    return output;
  }
}
