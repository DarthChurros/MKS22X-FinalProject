abstract class Component extends Element{
   private ArrayList<Element> terminals;
   private boolean isSource = false;
   //Function vToI;
   String type;
   int xStart;
   int yStart;
   int xEnd;
   int yEnd;
   
   
   
  
   // the default will just focus like a regular wire until given further specifications
  
   
   
   public String whatType(){
     return type;
   }
   
   
 
   float current() {
    //return vToI.eval(voltage());
    return 0.0;
  }
  
  void rotate() {
    
  }
   
  
   public void place(float xstart, float ystart, float xend, float yend){
     isPlaced = true;
   }
}
