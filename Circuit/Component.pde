abstract class Component extends Element {
  boolean isSource = false;
  int outx;
  int outy;
  ArrayList<Wire> input;
  ArrayList<Wire> output;

  boolean isSource() {
    return isSource;
  }


  // the default will just focus like a regular wire until given further specifications



  void rotate() {
  }

  ArrayList<Wire> in() {
    return input;
  }

  ArrayList<Wire> out() {
    return output;
  }
}
