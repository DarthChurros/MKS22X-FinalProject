import java.util.Scanner;

void setup(){
  size(1000,800);
  background(0,191,255);
  
  
  //ok lets make the grid
  
  for(int x = 15; x < 775; x +=40){
    line(x,15, x, 735);
    stroke(0,0,0);
    
    //just as a note - we need to round to the neares 40 then add 15
  }
  
  for(int x = 15; x < 775; x +=40){
    line(15, x, 735 , x);
    stroke(0,0,0);
  }
  
  
  
  
  
  
  
  
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


public static int rounder(float x){
  int y = int(x - 15);
  if(y % 40 < 20){
    return y/40 + 15;
  } else {
    return y/40 + 55;
  }
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
int[] v1;
int[] v2; 

//These are the holder vectors for the gui

void draw(){
  int counter = -1;
  if(overRect(750,90,200,50)){
    if(mousePressed){
      counter = 0;
    }
  }
  
   
   else if(overRect(750,190,200,50)){
    if(mousePressed){
      counter = 2;
    }
   }
   
   
   
   else if(overRect(750,290,200,50)){
    if(mousePressed){
      counter = 4;
    }
   }
   
   
   else if(mousePressed){
     if (counter == 0){
       int x = rounder(mouseX);
       int y = rounder(mouseY);
       v1 = new int[]{x, y};
       counter = 1;
       
     } else if(counter == 1){
       int x = rounder(mouseX);
       int y = rounder(mouseY);
       v2 = new int[]{x, y};
       Resistor r = new Resistor(v1[0], v1[1], v2[0], v2[1], 10);
       r.display();
       
       
     }
     
     
       
     
     
   }
   
    
 
  }
  //resistor
  
  
 
  
 
  
 
    
    
    
    
    
    
 
  
  
  
  
  
  //background(255);
  //rect(mouseX,mouseY,10,10);
  
  //if (mousePressed){
   // Node n = new Node(mouseX, mouseY);
    //n.display();
  
  
