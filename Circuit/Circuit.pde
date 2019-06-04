import java.util.Scanner;

void setup(){
  size(1000,800);

  
}


public static int rounder(float x){
  int y = int(x - 15);
  if(y % 40 < 20){ 
    return y/40 * 40 + 15;
  } else {
    return y/40 * 40 + 55;
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




//need a within radius functions



Element holdera;

//These are the holder vectors for the gui
int counter = -1;
ArrayList<Component> components = new ArrayList<Component>();
ArrayList<Component> sources = new ArrayList<Component>();
ArrayList<ArrayList<Wire>> nodes = new ArrayList<ArrayList<Wire>>();
//this has to be an element otherwise we wont be able to add wires
void draw(){
 
  //setup
  
  background(0,191,255);
  
  
  //ok lets make the grid
  
  for(int x = 15; x < 775; x +=40){
    stroke(0,0,0);
    strokeWeight(4);
    line(x,15, x, 735);
    
    
    //just as a note - we need to round to the neares 40 then add 15
  }
  
  for(int x = 15; x < 775; x +=40){
    stroke(0,0,0);
    strokeWeight(4);
    line(15, x, 735 , x);
   ;
  }
  
  
   for(int i = 0; i < components.size(); i++){
    components.get(i).display();
    if(components.get(i) != null){
      System.out.println("hyurd");
    }
  }
  
  for (int i = 0; i < sources.size(); i++) {
    sources.get(i).display();
  }
  
  for (int i = 0; i < nodes.size(); i++) {
    for (Wire w : nodes.get(i)) {
      w.display();
    }
  }
  
  
  //we want to make little buttons on the bottom so that the user can choose which component they want to place in
  String s = "Press for a new Resistor!";
  fill(255);
  stroke(0,0,0);
  strokeWeight(4);
  rect(750,90,200,50);
  fill(50);
  text(s, 770,100,100,100);
  
  //add
  //add
  
  String g = "Press for a new Cell!";
  fill(255);
  stroke(0,0,0);
  strokeWeight(4);
  rect(750,190,200,50);
  fill(50);
  text(g, 770,190,100,100);
  
  
  String h = "Press for a new Wire!";
  fill(255);
  stroke(0,0,0);
  strokeWeight(4);
  rect(750,290,200,50);
  fill(50);
  text(h, 770,290,100,100);
  
  //setup end
  
  
  if(overRect(750,90,200,50)){
    if(mousePressed){
      counter = 0;
      System.out.println(counter);
    }
  }
  
   
   else if(overRect(750,190,200,50)){
    if(mousePressed){
      counter = 2;
      //System.out.println("Pressed2");
    }
   }
   
   
   
   else if(overRect(750,290,200,50)){
    if(mousePressed){
      counter = 4;
    }
   }
   
   
   else if(counter == 0){
     if(holdera == null){
       //placing resistors
       holdera = new Resistor(int(mouseX), int(mouseY), int(mouseX) + 80, int(mouseY), 10);
       System.out.println("null");
     } else {
       holdera.shift(int(mouseX), int(mouseY), int(mouseX) + 80, int(mouseY));
     }
       holdera.display();
     if (mousePressed){
       counter = -1;
       int x = rounder(mouseX);
       
       int y = rounder(mouseY);
       System.out.println(x);
       System.out.println(y);
       Resistor r = new Resistor(x, y, x + 20, y, 10);
       r.place();
       r.display();
       System.out.println("test");
       components.add(r);
       
       
     } 
     
     
       
   }
   
   
   
   
   else if(counter == 2){
     //placing cells
     if(holdera == null){
       holdera = new VoltSource(int(mouseX), int(mouseY), int(mouseX) + 80, int(mouseY), 10);
       System.out.println("null");
     } else {
       holdera.shift(int(mouseX), int(mouseY), int(mouseX) + 80, int(mouseY));
     }
       holdera.display();
     if (mousePressed){
       counter = -1;
       int x = rounder(mouseX);
       
       int y = rounder(mouseY);
       System.out.println(x);
       System.out.println(y);
       VoltSource v = new VoltSource(x, y, x + 20, y, 10);
       v.place();
       v.display();
       System.out.println("test");
       sources.add(v);
       
       
     } 
     
     
   }
   
 
 
      else if(counter == 4){
     //placing wires
     if(holdera == null){
       holdera = new Wire(int(mouseX), int(mouseY), int(mouseX) + 80, int(mouseY));
       System.out.println("null");
     } else {
       holdera.shift(int(mouseX), int(mouseY), int(mouseX) + 80, int(mouseY));
     }
       holdera.display();
     if (mousePressed){
       counter = -1;
       int x = rounder(mouseX);
       int y = rounder(mouseY);
       System.out.println(x);
       System.out.println(y);
       Wire w = new Wire(x, y, x + 20, y);
       w.place();
       w.display();
       System.out.println("test");
       ArrayList temp = w.getNode();
       boolean makeNode = true;
       for (ArrayList<Wire> n : nodes) {
         if (n.contains(temp.get(0))) {
           n.add(w);
           makeNode = false;
         }
       }
       if (makeNode) {
         ArrayList<Wire> newNode = new ArrayList<Wire>();
         newNode.add(w);
         nodes.add(newNode);
       }
       
     } 
     
     
   }
   
    
   
  }
  //resistor
  
  
 
  
 
  
 
    
    
    
    
    
    
 
  
  
  
  
  
  //background(255);
  //rect(mouseX,mouseY,10,10);
  
  //if (mousePressed){
   // Node n = new Node(mouseX, mouseY);
    //n.display();
  
  
