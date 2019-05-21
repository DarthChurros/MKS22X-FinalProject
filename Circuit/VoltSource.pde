public class VoltSource extends Component{
  private float voltsIn;
  private float voltsOut;
  private float potentialDifference;
  private Node in;
  private Node out;
  
  
  
  public VoltSource(float voltage, float x, float y, Node inn, Node outt){
    potentialDifference = voltage;
    ArrayList<Element> stuff = new ArrayList<Element>();
    stuff.add(inn); stuff.add(out);
    super(stuff);
    
  }
  
  
  public void display(){
    
  }
  
  
  
  public float voltage(){
    return potentialDifference;
  }
  
  
  public float current(){
    return 0.0;
  }
}
