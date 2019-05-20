public class Function {
  String def;
  
  Function(String d) {
    def = d;
  }
  
  double eval(String s) {
    MyStack stack = new MyStack();
    String arg = "";
    for (int i = 0; i < s.length(); i++) {
      if (s.charAt(i) != ' ') {
        arg += s.charAt(i);
      } else {
        operate(stack, arg);
        arg = "";
      }
    }
    operate(stack, arg);
    return stack.getLast();
  }

  void operate(MyStack stack, String arg) {
    float temp;
    switch (arg) {
      case "+":
        stack.addLast(stack.removeLast() + stack.removeLast());
        break;
      case "-":
        temp = stack.removeLast();
        stack.addLast(stack.removeLast() - temp);
        break;
      case "*":
        stack.addLast(stack.removeLast() * stack.removeLast());
        break;
      case "/":
        temp = stack.removeLast();
        stack.addLast(stack.removeLast() / temp);
        break;
      case "%":
        temp = stack.removeLast();
        stack.addLast(stack.removeLast() % temp);
        break;
      default:
        stack.addLast(Float.parseFloat(arg));
    }
  }
}
