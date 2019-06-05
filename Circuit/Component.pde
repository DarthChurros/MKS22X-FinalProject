abstract class Component extends Element {
  boolean isSource = false;
  int outx;
  int outy;
  Wire input;
  Wire output;

  boolean isSource() {
    return isSource;
  }


  // the default will just focus like a regular wire until given further specifications
  void place() {
    super.place();
    for (ArrayList<Wire> node : nodes) {
      for (Wire w : node) {
        if (w.inx == inx && w.iny == iny) {
          input = w;
          w.in.add(this);
        }
        if (w.inx == outx && w.iny == outy) {
          output = w;
          w.in.add(this);
        }
        if (w.outx == inx && w.outy == iny) {
          input = w;
          w.out.add(this);
        }
        if (w.outx == outx && w.outy == outy) {
          output = w;
          w.out.add(this);
        }
      }
    }
  }


  void rotate() {
  }

  Wire in() {
    return input;
  }

  Wire out() {
    return output;
  }
}
