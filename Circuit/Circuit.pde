void setup(){
  size(1000,800);
  background(255);
  //we want to make little buttons on the bottom so that the user can choose which component they want to place in
  String s = "Press for a new Resistor!";
  fill(255);
  rect(750,90,200,50);
  fill(50);
  text(s, 770,100,100,100);
  
  
  
  String g = "Press for a new Cell!";
  fill(255);
  rect(750,190,200,50);
  fill(50);
  text(g, 770,190,100,100);
  
  
  
  
  
  String f = "Press for a new Wire!";
  fill(255);
  rect(750,290,200,50);
  fill(50);
  text(f, 770,290,100,100);
  
  
  
  
  
  
  
}

//these are for buttons
boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}







void draw(){
  
  
  
  //background(255);
  //rect(mouseX,mouseY,10,10);
  
  //if (mousePressed){
   // Node n = new Node(mouseX, mouseY);
    //n.display();
  }
  
