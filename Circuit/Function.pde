public class Function {
  String def;
  
  Function(String d) {
    def = d;
  }
  
  float eval(float arg) {
    MyStack stack = new MyStack();
    String s = "";
    for (int i = 0; i < def.length(); i++) {
      if (def.charAt(i) == 'x') {
        s += arg;
      } else if (def.charAt(i) != ' ') {
        s += def.charAt(i);
      } else {
        operate(stack, s);
        s = "";
      }
    }
    operate(stack, s);
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
      case "^":
        temp = stack.removeLast();
        stack.addLast(pow(stack.removeLast(), temp));
      default:
        stack.addLast(Float.parseFloat(arg));
    }
  }
}
