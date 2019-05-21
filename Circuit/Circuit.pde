void setup(){
  size(1000,800);
  background(255);
  //we want to make little buttons on the bottom so that the user can choose which component they want to place in
  
}


void draw(){
  if (mousePressed){
    Node n = new Node(mouseX, mouseY);
    n.display();

  /*
  fill(0);
  text("f(x) = 4x + 5", 10, height/2);
  Function f = new Function("4 x * 5 +");
  text("f(4) = " + f.eval("4 4 * 5 +"), 10, height/2+10);
  */
}
