public class Node extends Element{
  public ArrayList<Element> in = new ArrayList<Element>();
  ArrayList<Element> out = new ArrayList<Element>();
  
  
  public Node(ArrayList<Element> in, ArrayList<Element> out){
    in = this.in;
    out = this.out;
    
  }
  
  
  public Node(Element plugin, Element plugout){
    in.add(plugin);
    out.add(plugout);
  }
  
  
  public void addIn(Element input){
    in.add(intput);
  }
  
  public void addOut(Element Output){
    out.add(Output);
  }
  
  
  
  //Now we need a way of spreading voltage, and spreading current
}
