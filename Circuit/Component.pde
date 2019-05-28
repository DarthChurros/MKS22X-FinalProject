abstract class Component extends Element{
   private ArrayList<Element> terminals;
   private boolean isSource = false;
//<<<<<<< HEAD
//=======
   Function vToI;
//>>>>>>> master
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
    return vToI.eval(voltage());
  }
  
  void rotate() {
    
  }
   
   
   public void addTerminal(Node n){
     terminals.add(n);
   }
   
   public void place(float xstart, float ystart, float xend, float yend){
     isPlaced = true;
   }
}
