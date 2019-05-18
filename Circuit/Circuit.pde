import java.util.

public abstract class Element{
  private boolean isPlaced;
  private double x;
  private double y;
  private Node ground;
  
  public double getX(){
    return x;
  }
  
  public double getY(){
    return y;
  }
  
  

  
}

public class Node extends Element{
  private int x;
  private int y;
  private boolean isPlaced;
  
 
  
}
