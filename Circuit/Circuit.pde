import java.util.Scanner;

void setup(){
  size(1000,800);
  background(255);
  
  
  
  
  
  VoltSource V = new VoltSource(100, 100, 200, 100, 10);
  Wire w = new Wire(200, 100, 200, 200);
  Resistor r = new Resistor(200, 200, 100, 200,10);
  Wire v = new Wire(100, 200, 100, 100);
  
  
  
  V.display();
  r.display();
  w.display();
  v.display();
  
  //we want to make little buttons on the bottom so that the user can choose which component they want to place in
  String s = "Press for a new Resistor!";
  fill(255);
  rect(750,90,200,50);
  fill(50);
  text(s, 770,100,100,100);
  
  //add
  //add
  
  String g = "Press for a new Cell!";
  fill(255);
  rect(750,190,200,50);
  fill(50);
  text(g, 770,190,100,100);
  
  
  
  
  
  String h = "Press for a new Wire!";
  fill(255);
  rect(750,290,200,50);
  fill(50);
  text(h, 770,290,100,100);
  
  
  
  
  
  
  
}


public float totalResistance(){
    return 0.0;
    //idk how to do this but it seems like the only way to calculate the total resistance for a voltsource
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



//need a within radius functions



Element holdera;
Element holderb;



void draw(){
  
  
 Node Holderone;
 Node Holdertwo;
  //this is the default
  if(mousePressed && holdera == null){
    //Holder one is for a new piece, holder 2 is for finishing an old piece
    //so the button commands work
    if (overRect(750,90,200,50)){
     //holdera = new Resistor(Holderone, Holdertwo, )
      //ok, first off we need a popup windo to get the value of the restor
      
    // holderb = new Resistor(Holderone, Holder2, 10); 
     //Node Holderone = new Node(mouseX, mouseY, holdera,holderb);
     //
    }
    
    if (overRect(750,190,10,50)){
     //Holder  = new battery
    }
    
    if (overRect(750,290,10,50)){
     //holder  = new wire
    }
    
  }
  
  
  
  
  //background(255);
  //rect(mouseX,mouseY,10,10);
  
  //if (mousePressed){
   // Node n = new Node(mouseX, mouseY);
    //n.display();
  }
  
