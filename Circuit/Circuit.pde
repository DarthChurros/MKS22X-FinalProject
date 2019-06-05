import java.util.Scanner;
import java.util.Arrays;




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

void keyPressed() {
  if (key == 'r' || key == 'R') {
    rot = !rot;
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
  float[][] matrix = new float[nodes.size()][nodes.size()];
  for (int i = 0; i < nodes.size(); i++) {
    matrix[i] = nodes.get(i).get(0).relations(nodes);
  }
  System.out.println(Arrays.deepToString(matrix));
}


//need a within radius functions
Element holdera;

//These are the holder vectors for the gui
int counter = -1;
ArrayList<junction> junctions = new ArrayList<junction>();
//above well use these arraylists for junctions
ArrayList<Component> components = new ArrayList<Component>();
ArrayList<Component> sources = new ArrayList<Component>();
ArrayList<ArrayList<Wire>> nodes = new ArrayList<ArrayList<Wire>>();
//this has to be an element otherwise we wont be able to add wires

String totalResistance = "";

void draw() {
  
  
  
  
  background(0, 191, 255);
  //this is the connector for all the junctions
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


  for (int i = 0; i < components.size(); i++) {
    components.get(i).display();
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
  } else if (counter == 0) {

    //placing resistors


    holdera = new Resistor(int(mouseX), int(mouseY), int(mouseX) + 80, int(mouseY), 10);
    if (rot) holdera.rotate();


    stroke(255, 0, 0);
    holdera.display();



    if (mousePressed) {
      holdera = null;
      counter = -1;
      int x = rounder(mouseX);

      int y = rounder(mouseY);
      //System.out.println(x);
      //System.out.println(y);
      Resistor r = new Resistor(x, y, x + 80, y, 10);
      if (rot) r.rotate();
      junctions.add(r.a);
      junctions.add(r.b);
      r.place();
      r.display();
      System.out.println("test");
      components.add(r);
      updateMatrix = true;
    }
  } else if (counter == 2) {
    //placing cells

    holdera = new VoltSource(int(mouseX), int(mouseY), int(mouseX) + 80, int(mouseY), 10);
    if (rot) holdera.rotate();

    holdera.display();
    if (mousePressed) {
      holdera = null;
      counter = -1;
      int x = rounder(mouseX);

      int y = rounder(mouseY);
      System.out.println(x);
      System.out.println(y);
      VoltSource v = new VoltSource(x, y, x + 80, y, 10);
      
      if (rot) {
        v.rotate();
      }
      junctions.add(v.a);
      junctions.add(v.b);
      v.place();
      v.display();
      System.out.println("test");
      sources.add(v);
      updateMatrix = true;
    }
  } else if (counter == 4) {
    //placing wires

    holdera = new Wire(int(mouseX), int(mouseY), int(mouseX) + 40, int(mouseY));
    if (rot) holdera.rotate();
    //System.out.println("null");
    holdera.display();
    if (mousePressed) {
      holdera = null;
      counter = -1;
      int x = rounder(mouseX);
      int y = rounder(mouseY);
      System.out.println(x);
      System.out.println(y);
      Wire w = new Wire(x, y, x + 40, y);
      if (rot) w.rotate();
      junctions.add(w.a);
      junctions.add(w.b);
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
      updateMatrix = true;
    }
  }
  
  if (updateMatrix) updateVoltages();
}
//resistor



















//background(255);
//rect(mouseX,mouseY,10,10);

//if (mousePressed){
// Node n = new Node(mouseX, mouseY);
//n.display();
