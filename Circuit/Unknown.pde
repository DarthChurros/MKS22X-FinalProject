public class Unknown{
  //the only purpose for this class is for solving the system of equations in the nodal analysis
  public String name;
  public int value;
  public boolean solved;
  public Unknown(String n){
    name = n;
    value = -1;
  }
  
  public solve(int ans){
   value = ans;
   solved = true;
  }
}
