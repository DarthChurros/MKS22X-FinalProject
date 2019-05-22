abstract class Component extends Element {
  Function vToI;
  ArrayList<Wire> terminals;
  boolean isSource;
  
  float current() {
    return vToI.eval(voltage());
  }
}
