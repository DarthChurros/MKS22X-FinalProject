abstract class Component extends Element {
  boolean isSource = false;
  float resistance;
  boolean isSource() {
    return isSource;
  }

  int[] hitBox(){
    return new int[]{1,2,3,4};
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

  // the default will just focus like a regular wire until given further specifications
  //VERY IMPORTANT!!!, INPUT IS TO THE LEFT OR ABOVE, OUTPUT IS TO THE RIGHT OR BELOW
}
