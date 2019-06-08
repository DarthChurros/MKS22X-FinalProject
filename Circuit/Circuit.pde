import java.util.ArrayList;
import java.util.Arrays;
import static javax.swing.JOptionPane.*;




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


public static int hasDups(ArrayList<junction> a, int f){
  junction j = a.get(f);
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
  float[][] matrix = new float[nodes.size()][nodes.size()+1];
  matrix[0][0] = 1;
  matrix[0][nodes.size()] = 0;
  for (int i = 1; i < nodes.size(); i++) {
    matrix[i] = nodes.get(i).get(0).relations();
  }
  System.out.println(Arrays.deepToString(matrix) + "\n___________");
}


String ans = "";

//need a within radius functions
Component holdera;

//These are the holder vectors for the gui
int counter = -1;
ArrayList<junction> junctions = new ArrayList<junction>();
//above well use these arraylists for only one purpose - to check for duplicates
ArrayList<Resistor> components = new ArrayList<Resistor>();
ArrayList<VoltSource> sources = new ArrayList<VoltSource>();
ArrayList<Wire> wires = new ArrayList<Wire>();
ArrayList<ArrayList<junction>> nodes = new ArrayList<ArrayList<junction>>();
//this has to be an Component otherwise we wont be able to add wires

String totalResistance = "";

void draw() {
  
  background(0, 191, 255);
  //i have this in the draw loop so it constantly merges all the annoying
  for(int i = 0; i < junctions.size(); i++){
    if(hasDups(junctions, i) > 0){
      junctions.remove(hasDups(junctions, i));
    }
  }
  
  String run = "RUN";
  fill(255);
  stroke(0, 0, 0);
  strokeWeight(4);
  rect(750, 390, 200, 50);
  fill(50);
  text(run, 825, 405, 100, 100);
  
   //NOW WE HAVE ALL THE JUNCTIONS IN A LIST
  //WE CAN MAKE A RUN BUTTON FOR WHEN THE CIRCUIT IS DONE, AND THE JUNCTIONS WILL BE IN ORDER
  
  if(overRect(750,390,200,50)){
    if(mousePressed){
      mousePressed = false;
      //this is the run function
      //lets solve the circuit
      //first step to nodal analysis --> Pick a ground
      //lets make that the first junction thats connected to a volageSource
      try{
        int groundJunct = 0;
        boolean hasBattery = false;
        for(int i = 0; i < junctions.size(); i++){
         if(junctions.get(i).voltsOut()){
           hasBattery = true;
           groundJunct = i;
           break;
         }
        }
        if(!hasBattery){
          throw new NullPointerException();
        }
        
        junctions.get(groundJunct).relativeVoltage = 0;
        //at this point we've now defined out ground, so its time do do step two, which is to find the easy nodes
        //basically these are all the ones where we don't have to cross a resistor
        //since the node we picked has the output as a voltagesource, obv the next node will just be trivially up by the voltage
        junctions.get(groundJunct + 1).relativeVoltage = junctions.get(groundJunct).terminals.get(0).voltage();
        
        
        
        //oh, its also important what we want to output in our results box
        //basically, we can loop through the list of junctions and give each junction a number
        //then, in the box, we can output each junction, their voltage relative to ground, and their current value
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


  for (ArrayList<junction> node : nodes) {
    for (junction j : node) {
      //System.out.println(j.terminals);
      for (Component e : j.terminals) {
        e.display();
      }
    }
  }


  //we want to make little buttons on the bottom so that the user can choose which component they want to place in
  String s = "Press for a new Resistor!";
  fill(255);
  stroke(0, 0, 0);
  strokeWeight(4);
  rect(750, 90, 200, 50);
  fill(50);
  text(s, 770, 100, 100, 100);

  //add
  //add

  String g = "Press for a new Cell!";
  fill(255);
  stroke(0, 0, 0);
  strokeWeight(4);
  rect(750, 190, 200, 50);
  fill(50);
  text(g, 770, 190, 100, 100);

  String h = "Press for a new Wire!";
  fill(255);
  stroke(0, 0, 0);
  strokeWeight(4);
  rect(750, 290, 200, 50);
  fill(50);
  text(h, 770, 290, 100, 100);
  
  text("Number of nodes: "+nodes.size() +" "+ pressed + " " + mousePressed, 770, 600, 100, 100);

  //setup end

  boolean updateMatrix = false;


  if (overRect(750, 90, 200, 50)) {
    if (mousePressed) {
      counter = 0;
      // System.out.println(counter);
    }
  } else if (overRect(750, 190, 200, 50)) {
    if (mousePressed) {
      counter = 2;
      //System.out.println("Pressed2");
    }
  } else if (overRect(750, 290, 200, 50)) {
    if (mousePressed) {
      counter = 4;
    }
  } else if (counter == 0 || pressed == 'a' || pressed == 'A') {

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
      for (ArrayList<junction> n : nodes) {
        for (junction j : n) {
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
        ArrayList<junction> newNode = new ArrayList<junction>();
        newNode.add(r.a);
        nodes.add(newNode);
      }
      if (makeNodeB) {
        ArrayList<junction> newNode = new ArrayList<junction>();
        newNode.add(r.b);
        nodes.add(newNode);
      }
      
      updateMatrix = true;
    }
  } else if (counter == 2 || pressed == 'v' || pressed == 'V') {
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
      for (ArrayList<junction> n : nodes) {
        for (junction j : n) {
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
        ArrayList<junction> newNode = new ArrayList<junction>();
        newNode.add(v.a);
        nodes.add(newNode);
      }
      if (makeNodeB) {
        ArrayList<junction> newNode = new ArrayList<junction>();
        newNode.add(v.b);
        nodes.add(newNode);
      }
      updateMatrix = true;
    }
  } else if (counter == 4 || pressed == 'w' || pressed == 'W') {
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
      for (ArrayList<junction> n : nodes) {
        for (junction j : n) {
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
        ArrayList<junction> newNode = new ArrayList<junction>();
        newNode.add(w.a);
        newNode.add(w.b);
        nodes.add(newNode);
      } else if (makeNodeA) {
        //System.out.println("adding junction A to node");
        for (int i = 0; i < nodes.size(); i++) {
          if (nodes.get(i).contains(w.b)) {
            //System.out.println("found node, adding...");
            nodes.get(i).add(w.a);
            i = nodes.size();
          }
        }
      } else if (makeNodeB) {
        for (int i = 0; i < nodes.size(); i++) {
          //System.out.println("adding junction B to node");
          if (nodes.get(i).contains(w.a)) {
            nodes.get(i).add(w.b);
            i = nodes.size();
          }
        }
      } else {
        ArrayList nodeA = new ArrayList();
        ArrayList nodeB = new ArrayList();
        for (ArrayList<junction> node : nodes) {
          if (node.contains(w.a)) nodeA = node;
          if (node.contains(w.b)) nodeB = node;
        }
        nodeA.addAll(nodeB);
        nodeB.clear();
      }
      updateMatrix = true;
      w.display();
    }
  } else if(pressed == BACKSPACE) {
    //THIS IS THE DELETE SECTION
    //STARTS WITH RESISTORS
    if(mousePressed){
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
      
    
    
  
  
  if (updateMatrix) {
    for (int i = 0; i < nodes.size(); i++) {
      if (nodes.get(i).size() < 1) {
        nodes.remove(i);
        i--;
      }
    }
    //System.out.println(nodes);
    //System.out.println("______");
    updateVoltages();
  }
 
}
//resistor



















//background(255);
//rect(mouseX,mouseY,10,10);

//if (mousePressed){
// Node n = new Node(mouseX, mouseY);
//n.display();
