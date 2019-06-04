abstract class Component extends Element {
  boolean isSource = false;
  int inx;
  int iny;
  int outx;
  int outy;
  Wire input;
  Wire output;

  boolean isSource() {
    return isSource;
  }


  // the default will just focus like a regular wire until given further specifications



  void rotate() {
  }

  Wire in() {
    return input;
  }

  Wire out() {
    return output;
  }
}
