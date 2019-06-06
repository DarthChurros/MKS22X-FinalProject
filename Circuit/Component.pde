abstract class Component extends Element {
  boolean isSource = false;
  int outx;
  int outy;

  boolean isSource() {
    return isSource;
  }


  // the default will just focus like a regular wire until given further specifications
  //VERY IMPORTANT!!!, INPUT IS TO THE LEFT OR ABOVE, OUTPUT IS TO THE RIGHT OR BELOW


  void rotate() {
  }
}
