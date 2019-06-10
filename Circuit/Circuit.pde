import java.util.ArrayList;
import java.util.Arrays;
import java.lang.*;
import static javax.swing.JOptionPane.*;


boolean directions = true;

void setup() {
  size(1000, 800);
}


public static int rounder(float x) {
  int y = int(x - 15);
  if (y % 40 < 20) { 
    return y/40 * 40 + 15;
  } else {
    return y/40 * 40 + 55;
  }
}

boolean rot = false;
char pressed;
void keyPressed() {
  if (key == 'r' || key == 'R') {
    rot = !rot;
  }
  if(key == 'v' || key == 'V' || key == 'a' || key == 'A' || key == 'w' || key == 'W' || key == BACKSPACE){
    pressed = key;
    //System.out.println('l');
  }
 
}

public float totalResistance() {
  return 0.0;
  //idk how to do this but it seems like the only way to calculate the total resistance for a voltsource
}


public static int hasDups(ArrayList<Junction> a, int f){
  Junction j = a.get(f);
  for(int i = 0; i < a.size() ; i++){
    if(a.get(i).x == j.x && a.get(i).y == j.y && i != f){
      //they have the same coords
      return i;
    }
  }
  
  return -1;
}

//these are for buttons
boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void updateVoltages() {
  
  //System.out.println(nodes.size());
  float[][] matrix = new float[nodes.size()][nodes.size()+1];
  matrix[0][0] = 1;
  matrix[0][nodes.size()] = 0;
  for (int i = 1; i < nodes.size(); i++) {
    matrix[i] = nodes.get(i).get(0).relations();
  }
  System.out.println(Arrays.deepToString(matrix) + "\n|\n|\n|\nV");
  toIdentity(matrix);
  System.out.println(Arrays.deepToString(matrix) + "\n___________");
  for (int i = 0; i < nodes.size(); i++) {
    for (Junction j : nodes.get(i)) {
      j.relativeVoltage = matrix[i][nodes.size()];
    }
  }
  
}

void toIdentity(float[][] matrix) {
  if (!matrixValid(matrix)) throw new IllegalArgumentException ("Matrix dimensions invalid!");

  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix.length; j++) {
      if (j != i && matrix[j][i] != 0) {
        matrixMultiply(matrix, j, -1*matrix[i][i]/matrix[j][i]);
        matrixAdd(matrix, j, i);
      }
    }
    System.out.println(Arrays.deepToString(matrix) + "\n|\n|\n|\nV");
  }
  
  for (int i = 0; i < matrix.length; i++) {
    matrixMultiply(matrix, i, 1/matrix[i][i]);
  }
}

void matrixAdd(float[][] matrix, int r1, int r2) {
  if (!matrixValid(matrix)) throw new IllegalArgumentException("Matrix dimensions invalid!");
  if (r1 >= matrix.length || r1 < 0 || r2 >= matrix.length || r2 < 0) throw new IllegalArgumentException("Target rows out of bounds!");
  
  for (int i = 0; i < matrix[r1].length; i++) {
    matrix[r1][i] += matrix[r2][i];
  }
}

void matrixMultiply(float[][] matrix, int r, float factor) {
  if (!matrixValid(matrix)) throw new IllegalArgumentException("Matrix dimensions invalid!");
  if (r >= matrix.length || r < 0) throw new IllegalArgumentException("Target row out of bounds!");
  
  for (int i = 0; i < matrix[r].length; i++) {
    matrix[r][i] *= factor;
  }
}

boolean matrixValid(float[][] matrix) {
  for (float[] row : matrix) {
    if (row.length != matrix.length + 1) return false;
  }
  return true;
}


boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter ) {
    return true;
  } else {
    return false;
  }
}



String ans = "";

//need a within radius functions
Component holdera;

//These are the holder vectors for the gui
int counter = -1;
ArrayList<Junction> junctions = new ArrayList<Junction>();
//above well use these arraylists for only one purpose - to check for duplicates
ArrayList<Resistor> components = new ArrayList<Resistor>();
ArrayList<VoltSource> sources = new ArrayList<VoltSource>();
ArrayList<Wire> wires = new ArrayList<Wire>();
ArrayList<ArrayList<Junction>> nodes = new ArrayList<ArrayList<Junction>>();
//this has to be an Component otherwise we wont be able to add wires

String totalResistance = "";

void draw() {
   
  if(directions){
    background(0, 191, 255);
    
    fill(50);
    textSize(32);
    text("Circuit Simulator Directions", 260, 100);
    
    
    fill(75);
    textSize(32);
    text("Resistors: Press the 'a' key \nBatteries: Press the 'v' key \nWires: Press the 'w' key  ", 100,200);
    
    fill(75);
    textSize(32);
    text("You may only place components on the grid", 100, 350);
    
    fill(75);
    textSize(24);
    text("Check the validity of your circuit by hitting 'Test'", 100,450);
    
    fill(75);
    textSize(24);
    text("Hover over a white circle to solve the circuit at that point", 100,500);
    
    stroke(0);
    strokeWeight(4);
    fill(255);
    rect(100,600,300,75);
    
    fill(75);
    textSize(24);
    text("New Circuit", 100,600,300,75);
    
    
    if(overRect(100,600,300,75)){
      if(mousePressed){
        directions = false;
      }
    }
    
    
    
  } else {
  background(0, 191, 255);
  //i have this in the draw loop so it constantly merges all the annoying
   for(int i = 0; i < junctions.size(); i++){
    if(hasDups(junctions, i) > 0){
     junctions.remove(hasDups(junctions, i));
    }
  }
  
  
  
  
  String run = "Test";
  fill(255);
  stroke(0, 0, 0);
  strokeWeight(4);
  rect(750, 390, 200, 50);
  fill(50);
  textSize(32);
  text(run, 825, 405, 100, 100);
  textSize(12);
  
  fill(255);
  stroke(0, 0, 0);
  strokeWeight(4);
  rect(750, 290, 200, 50);
  
  
  
 
  
   //NOW WE HAVE ALL THE junctions IN A LIST
  //WE CAN MAKE A RUN BUTTON FOR WHEN THE CIRCUIT IS DONE, AND THE junctions WILL BE IN ORDER
  
  if(overRect(750,390,200,50)){
    if(mousePressed){
      mousePressed = false;
      //this is the run function
      //lets solve the circuit
      //first step to nodal analysis --> Pick a ground
      //lets make that the first Junction thats connected to a volageSource
      try{
        int groundJunct = 0;
        boolean hasBattery = false;
        boolean hasResistor = false;
        boolean connected = true;
        for(int i = 0; i < junctions.size(); i++){
         if(junctions.get(i).voltsOut()){
           hasBattery = true;
           groundJunct = i;
           break;
         }
         
         if(Float.isNaN(junctions.get(i).relativeVoltage)) throw new NullPointerException();
         
         
        }
        if(!hasBattery){
          throw new NullPointerException();
        }
        
        
        ans = "good to go";
        //oh, its also important what we want to output in our results box
        //basically, we can loop through the list of junctions and give each Junction a number
        //then, in the box, we can output each Junction, their voltage relative to ground, and their current value
      } catch (Exception e){
        ans = "Enter a valid circuit";
        
      }
    }
  }
  
  
  
  
  
  fill(255);
  stroke(0, 0, 0);
  strokeWeight(4);
  rect(750, 490, 200, 50);
  fill(50);
  text(ans, 820, 500, 100, 100);
   
   
   
  fill(255);
  stroke(0, 0, 0);
  strokeWeight(4);
  rect(750, 690, 200, 50);
  fill(10);
  textSize(32);
  text("Reset", 808, 699, 6000, 60);
  textSize(12);
  
  
   
   
   
 
  //System.out.println(junctions.size());
  
  
  //ok it links 
  
  //setup

  //ok lets make the grid

  for (int x = 15; x < 775; x +=40) {
    stroke(0, 0, 0);
    strokeWeight(4);
    line(x, 15, x, 735);


    //just as a note - we need to round to the neares 40 then add 15
  }

  for (int x = 15; x < 775; x +=40) {
    stroke(0, 0, 0);
    strokeWeight(4);
    line(15, x, 735, x);
  }


  for (ArrayList<Junction> node : nodes) {
    for (Junction j : node) {
      //System.out.println(j.terminals);
      for (Component e : j.terminals) {
        e.display();
      }
    }
  }
  
  
  for(int i = 0; i < nodes.size(); i++){
    for(int j = 0; j< nodes.get(i).size(); j++){
      if(overCircle(nodes.get(i).get(j).x, nodes.get(i).get(j).y, 15)){
        nodes.get(i).get(j).showFacts = true;
      } else {
        nodes.get(i).get(j).showFacts = false;
      }
    }
  }
  
  
  


  
  text("Number of nodes: "+nodes.size() +" "+ pressed + " " + mousePressed, 770, 600, 100, 100);

  //setup end

  boolean updateMatrix = false;


  

  if (pressed == 'a' || pressed == 'A') {

    //placing resistors


    holdera = new Resistor(int(mouseX), int(mouseY), int(mouseX) + 80, int(mouseY), 10);
    if (rot) holdera.rotate();


    stroke(255, 0, 0);
    holdera.display();



    if (mousePressed) {
      holdera = null;
      counter = -1;
      pressed = '-';
      mousePressed = false;
      int x = rounder(mouseX);

      int y = rounder(mouseY);
      //System.out.println(x);
      //System.out.println(y);
      
     
      float val = 0;
      while(val <= 0){
      String value = showInputDialog("How many ohms of resistance would you like? ");
      try{
      val = Float.parseFloat(value);
      } catch(Exception e){
        System.out.println("NO");
      }
      }
      //System.out.println(val);
      Resistor r = new Resistor(x, y, x + 80, y, val);
      //System.out.println(r.resistance);
      if (rot) r.rotate();
      junctions.add(r.a);
      junctions.add(r.b);
      r.place();
      r.display();
      r.hitBox();
      //System.out.println("test");
      components.add(r);
      //just to see
      
      
      boolean makeNodeA = true;
      boolean makeNodeB = true;
      for (ArrayList<Junction> n : nodes) {
        for (Junction j : n) {
          if (rounder(j.x) == rounder(r.a.x)
          && rounder(j.y) == rounder(r.a.y)) {
            j.merge(r.a);
            makeNodeA = false;
          }
          if (rounder(j.x) == rounder(r.b.x)
          && rounder(j.y) == rounder(r.b.y)) {
            j.merge(r.b);
            makeNodeB = false;
          }
        }
      }
      if (makeNodeA) {
        ArrayList<Junction> newNode = new ArrayList<Junction>();
        newNode.add(r.a);
        nodes.add(newNode);
      }
      if (makeNodeB) {
        ArrayList<Junction> newNode = new ArrayList<Junction>();
        newNode.add(r.b);
        nodes.add(newNode);
      }
      
      updateMatrix = true;
    }
  } else if (pressed == 'v' || pressed == 'V') {
    //placing cells

    holdera = new VoltSource(int(mouseX), int(mouseY), int(mouseX) + 80, int(mouseY), 10);
    if (rot) holdera.rotate();

    holdera.display();
    if (mousePressed) {
      mousePressed = false;
      holdera = null;
      counter = -1;
       pressed = '-';
      int x = rounder(mouseX);

      int y = rounder(mouseY);
      //System.out.println(x);
      //System.out.println(y);
      float val = 0;
      while(val <= 0){
      String value = showInputDialog("How many volts would you like? ");
      try{
      val = Float.parseFloat(value);
      } catch(Exception e){
        System.out.println("NO");
      }
      }
      VoltSource v = new VoltSource(x, y, x + 80, y, val);
      
      if (rot) {
        v.rotate();
      }
      junctions.add(v.a);
      junctions.add(v.b);
      v.place();
      v.display();
      sources.add(v);
      
      boolean makeNodeA = true;
      boolean makeNodeB = true;
      for (ArrayList<Junction> n : nodes) {
        for (Junction j : n) {
          if (rounder(j.x) == rounder(v.a.x)
          && rounder(j.y) == rounder(v.a.y)) {
            j.merge(v.a);
            makeNodeA = false;
          }
          if (rounder(j.x) == rounder(v.b.x)
          && rounder(j.y) == rounder(v.b.y)) {
            j.merge(v.b);
            makeNodeB = false;
          }
        }
      }
      if (makeNodeA) {
        ArrayList<Junction> newNode = new ArrayList<Junction>();
        newNode.add(v.a);
        nodes.add(newNode);
      }
      if (makeNodeB) {
        ArrayList<Junction> newNode = new ArrayList<Junction>();
        newNode.add(v.b);
        nodes.add(newNode);
      }
      updateMatrix = true;
    }
  } else if (pressed == 'w' || pressed == 'W') {
    //placing wires
    
    holdera = new Wire(int(mouseX), int(mouseY), int(mouseX) + 40, int(mouseY));
    if (rot) holdera.rotate();
    //System.out.println("null");
    holdera.display();
    if (mousePressed) {
       pressed = '-';
      holdera = null;
      counter = -1;
      mousePressed = false;
      int x = rounder(mouseX);
      int y = rounder(mouseY);
      //System.out.println(x);
      //System.out.println(y);
      Wire w = new Wire(x, y, x + 40, y);
      if (rot) w.rotate();
      junctions.add(w.a);
      junctions.add(w.b);
      wires.add(w);
      w.place();

      boolean makeNodeA = true;
      boolean makeNodeB = true;
      for (ArrayList<Junction> n : nodes) {
        for (Junction j : n) {
          if (rounder(j.x) == rounder(w.a.x)
          && rounder(j.y) == rounder(w.a.y)) {
            j.merge(w.a);
            makeNodeA = false;
          }
          if (rounder(j.x) == rounder(w.b.x)
          && rounder(j.y) == rounder(w.b.y)) {
            j.merge(w.b);
            makeNodeB = false;
          }
        }
      }
      if (makeNodeA && makeNodeB) {
        //System.out.println("making a new node");
        ArrayList<Junction> newNode = new ArrayList<Junction>();
        newNode.add(w.a);
        newNode.add(w.b);
        nodes.add(newNode);
      } else if (makeNodeA) {
        //System.out.println("adding Junction A to node");
        for (int i = 0; i < nodes.size(); i++) {
          if (nodes.get(i).contains(w.b)) {
            //System.out.println("found node, adding...");
            nodes.get(i).add(w.a);
            i = nodes.size();
          }
        }
      } else if (makeNodeB) {
        for (int i = 0; i < nodes.size(); i++) {
          //System.out.println("adding Junction B to node");
          if (nodes.get(i).contains(w.a)) {
            nodes.get(i).add(w.b);
            i = nodes.size();
          }
        }
      } else {
        ArrayList nodeA = new ArrayList();
        ArrayList nodeB = new ArrayList();
        for (ArrayList<Junction> node : nodes) {
          if (node.contains(w.a)) nodeA = node;
          if (node.contains(w.b)) nodeB = node;
        }
        nodeA.addAll(nodeB);
        nodeB.clear();
        System.out.println(nodes.size());
      }
      
      updateMatrix = true;
      w.display();
    }
  } else if(pressed == BACKSPACE) {
    //THIS IS THE DELETE SECTION
    //STARTS WITH RESISTORS
    if(mousePressed){
      if(nodes.size() <= 2 && components.size() + wires.size() + sources.size() <= 1){
      junctions = new ArrayList<Junction>();
    //above well use these arraylists for only one purpose - to check for duplicates
      components = new ArrayList<Resistor>();
      sources = new ArrayList<VoltSource>();
      wires = new ArrayList<Wire>();
      nodes = new ArrayList<ArrayList<Junction>>();
      updateMatrix = false;
      
    } else {
      mousePressed = false;
      //ok so basically now we need to see if this thing is over some sort of component
      for(int i = 0; i < components.size(); i++){
        //check the resistors
        //System.out.println(components.get(i).resistance);
        int[] hitbox = components.get(i).hitBox();
        if(overRect(hitbox[0], hitbox[1], hitbox[2], hitbox[3])){
          
          String ans = components.get(i).deleteCheck();
          
         //System.out.println(ans + "1");
          if(ans.equals("")){
            //THE TERMINALS JUDE
            System.out.println("work");
            components.get(i).a.terminals.remove(components.get(i));
           
            components.get(i).b.terminals.remove(components.get(i));
            
            components.remove(i); 
            i--;
            //keep the junctions there
          }
          
          //^^that delete works
          
          if(ans.equals("ab")){
            for(int j = 0; j < nodes.size(); j++){
           //ok we need to do some searching for the junctions and remove them)
           
            if(nodes.get(j).contains(components.get(i).a)){
              System.out.println("branch");
              nodes.get(j).remove(components.get(i).a);
              junctions.remove(components.get(i).a);
              
            }
            if(nodes.get(j).contains(components.get(i).b)){
              nodes.get(j).remove(components.get(i).b);
              junctions.remove(components.get(i).b);
            }
            }
            
            for(int j = 0; j < nodes.size(); j++){
              if(nodes.get(j).size() == 0){
                nodes.remove(j);
                j--;
              }
            }
            
            
            components.remove(i); 
            i--;
            
            
           }
           
           
           
           
           if(ans.equals("a")){
            for(int j = 0; j < nodes.size(); j++){
           //ok we need to do some searching for the junctions and remove them)
           
            if(nodes.get(j).contains(components.get(i).a)){
              System.out.println("branch");
              nodes.get(j).remove(components.get(i).a);
              junctions.remove(components.get(i).a);
              
            }
            
            
            if(nodes.get(j).contains(components.get(i).b)){
              components.get(i).b.terminals.remove(components.get(i));
              //removing this from the b terminal so that it doesnt display anymore
            }
           
            }
            
            for(int j = 0; j < nodes.size(); j++){
              if(nodes.get(j).size() == 0){
                nodes.remove(j);
                j--;
              }
            }
            
            
            components.remove(i); 
            i--;
            
            
           }
           
           
           
           
           if(ans.equals("b")){
            for(int j = 0; j < nodes.size(); j++){
           //ok we need to do some searching for the junctions and remove them)
           
            if(nodes.get(j).contains(components.get(i).b)){
              System.out.println("branch");
              nodes.get(j).remove(components.get(i).b);
              junctions.remove(components.get(i).b);
              
            }
            
            
            if(nodes.get(j).contains(components.get(i).a)){
              components.get(i).a.terminals.remove(components.get(i));
              //removing this from the b terminal so that it doesnt display anymore
            }
           
            }
            
            for(int j = 0; j < nodes.size(); j++){
              if(nodes.get(j).size() == 0){
                nodes.remove(j);
                j--;
              }
            }
            
            
            components.remove(i); 
            i--;
            
            
           }
           
           
           
         
          }
        }
        
        //RESISTOR SECTION OVER
        //NOW WE CAN DO Batteries
        
        for(int i = 0; i < sources.size(); i++){
        //check the resistors
        //System.out.println(components.get(i).resistance);
        int[] hitbox = sources.get(i).hitBox();
        if(overRect(hitbox[0], hitbox[1], hitbox[2], hitbox[3])){
          
          String ans = sources.get(i).deleteCheck();
          
         //System.out.println(ans + "1");
          if(ans.equals("")){
            //THE TERMINALS JUDE
            System.out.println("work");
            sources.get(i).a.terminals.remove(sources.get(i));
           
            sources.get(i).b.terminals.remove(sources.get(i));
            
            sources.remove(i); 
            i--;
            //keep the junctions there
          }
          
          //^^that delete works
          
          if(ans.equals("ab")){
            for(int j = 0; j < nodes.size(); j++){
           //ok we need to do some searching for the junctions and remove them)
           
            if(nodes.get(j).contains(sources.get(i).a)){
              System.out.println("branch");
              nodes.get(j).remove(sources.get(i).a);
              junctions.remove(sources.get(i).a);
              
            }
            if(nodes.get(j).contains(sources.get(i).b)){
              nodes.get(j).remove(sources.get(i).b);
              junctions.remove(sources.get(i).b);
            }
            }
            
            for(int j = 0; j < nodes.size(); j++){
              if(nodes.get(j).size() == 0){
                nodes.remove(j);
                j--;
              }
            }
            
            
            sources.remove(i); 
            i--;
            
            
           }
           
           
           
           
           if(ans.equals("a")){
            for(int j = 0; j < nodes.size(); j++){
           //ok we need to do some searching for the junctions and remove them)
           
            if(nodes.get(j).contains(sources.get(i).a)){
              System.out.println("branch");
              nodes.get(j).remove(sources.get(i).a);
              junctions.remove(sources.get(i).a);
              
            }
            
            
            if(nodes.get(j).contains(sources.get(i).b)){
              sources.get(i).b.terminals.remove(sources.get(i));
              //removing this from the b terminal so that it doesnt display anymore
            }
           
            }
            
            for(int j = 0; j < nodes.size(); j++){
              if(nodes.get(j).size() == 0){
                nodes.remove(j);
                j--;
              }
            }
            
            
            sources.remove(i); 
            i--;
            
            
           }
           
           
           
           
           if(ans.equals("b")){
            for(int j = 0; j < nodes.size(); j++){
           //ok we need to do some searching for the junctions and remove them)
           
            if(nodes.get(j).contains(sources.get(i).b)){
              System.out.println("branch");
              nodes.get(j).remove(sources.get(i).b);
              junctions.remove(sources.get(i).b);
              
            }
            
            
            if(nodes.get(j).contains(sources.get(i).a)){
              sources.get(i).a.terminals.remove(sources.get(i));
              //removing this from the b terminal so that it doesnt display anymore
            }
           
            }
            
            for(int j = 0; j < nodes.size(); j++){
              if(nodes.get(j).size() == 0){
                nodes.remove(j);
                j--;
              }
            }
            
            
            sources.remove(i); 
            i--;
            
            
           }
           
           
           
         
          }
        }
        
        
        //Wire time
        
        for(int i = 0; i < wires.size(); i++){
        //check the resistors
        //System.out.println(components.get(i).resistance);
        int[] hitbox = wires.get(i).hitBox();
        if(overRect(hitbox[0], hitbox[1], hitbox[2], hitbox[3])){
          
          String ans = wires.get(i).deleteCheck();
          
         //System.out.println(ans + "1");
          if(ans.equals("")){
            //THE TERMINALS JUDE
            System.out.println("work");
            wires.get(i).a.terminals.remove(wires.get(i));
           
            wires.get(i).b.terminals.remove(wires.get(i));
            
            wires.remove(i); 
            i--;
            //keep the junctions there
          }
          
          //^^that delete works
          
          if(ans.equals("ab")){
            for(int j = 0; j < nodes.size(); j++){
           //ok we need to do some searching for the junctions and remove them)
           
            if(nodes.get(j).contains(wires.get(i).a)){
              System.out.println("branch");
              nodes.get(j).remove(wires.get(i).a);
              junctions.remove(wires.get(i).a);
              
            }
            if(nodes.get(j).contains(wires.get(i).b)){
              nodes.get(j).remove(wires.get(i).b);
              junctions.remove(wires.get(i).b);
            }
            }
            
            for(int j = 0; j < nodes.size(); j++){
              if(nodes.get(j).size() == 0){
                nodes.remove(j);
                j--;
              }
            }
            
            
            wires.remove(i); 
            i--;
            
            
           }
           
           
           
           
           if(ans.equals("a")){
            for(int j = 0; j < nodes.size(); j++){
           //ok we need to do some searching for the junctions and remove them)
           
            if(nodes.get(j).contains(wires.get(i).a)){
              System.out.println("branch");
              nodes.get(j).remove(wires.get(i).a);
              junctions.remove(wires.get(i).a);
              
            }
            
            
            if(nodes.get(j).contains(wires.get(i).b)){
              wires.get(i).b.terminals.remove(wires.get(i));
              //removing this from the b terminal so that it doesnt display anymore
            }
           
            }
            
            for(int j = 0; j < nodes.size(); j++){
              if(nodes.get(j).size() == 0){
                nodes.remove(j);
                j--;
              }
            }
            
            
            wires.remove(i); 
            i--;
            
            
           }
           
           
           
           
           if(ans.equals("b")){
            for(int j = 0; j < nodes.size(); j++){
           //ok we need to do some searching for the junctions and remove them)
           
            if(nodes.get(j).contains(wires.get(i).b)){
              System.out.println("branch");
              nodes.get(j).remove(wires.get(i).b);
              junctions.remove(wires.get(i).b);
              
            }
            
            
            if(nodes.get(j).contains(wires.get(i).a)){
              wires.get(i).a.terminals.remove(wires.get(i));
              //removing this from the b terminal so that it doesnt display anymore
            }
           
            }
            
            for(int j = 0; j < nodes.size(); j++){
              if(nodes.get(j).size() == 0){
                nodes.remove(j);
                j--;
              }
            }
            
            
            wires.remove(i); 
            i--;
            
            
           }
           
           
           
         
          }
        }
        //DELETE DONE vv
        
    }
    }
        
        updateMatrix = true;
      }
      
    
    if(overRect(750, 690, 200, 50)){
    if(mousePressed){
      junctions = new ArrayList<Junction>();
//above well use these arraylists for only one purpose - to check for duplicates
      components = new ArrayList<Resistor>();
      sources = new ArrayList<VoltSource>();
      wires = new ArrayList<Wire>();
      nodes = new ArrayList<ArrayList<Junction>>();
      //System.out.println(nodes.size());
      if(pressed == BACKSPACE){
        pressed = '-';
        updateMatrix = false;
      }
    }
  }
  
  //setting the groudn
  float groundVoltage = 0;
  for(int i = 0; i < nodes.size(); i++){
    for(int j = 0; j < nodes.get(i).size(); j++){
      if(overCircle(nodes.get(i).get(j).x, nodes.get(i).get(j).y, 15) && mousePressed){
        groundVoltage = nodes.get(i).get(j).relativeVoltage;
          System.out.println("gi" + groundVoltage);
      }
    }
  }
  
  //System.out.println("g" + groundVoltage);
    
  
  
  
  if (updateMatrix) {
    for (int i = 0; i < nodes.size(); i++) {
      if (nodes.get(i).size() < 1) {
        
        nodes.remove(i);
        i--;
      }
    }
    //System.out.println(nodes);
    //System.out.println("______");
    
    try{
    updateVoltages();
    } catch(ArrayIndexOutOfBoundsException e){
    }
    
    
    
  }
 
}
}
//resistor

















//important bugs -->
//NaN voltages in some combo circuits
//square of wires



//background(255);
//rect(mouseX,mouseY,10,10);

//if (mousePressed){
// Node n = new Node(mouseX, mouseY);
//n.display();
