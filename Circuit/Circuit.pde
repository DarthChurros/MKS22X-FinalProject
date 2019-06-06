
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

//matrix methodsvv

static public void rref(double [][] m){
    int lead = 0;
    int rowCount = m.length;
    int colCount = m[0].length;
    int i;
    boolean quit = false;

    for(int row = 0; row < rowCount && !quit; row++)
    {
        print(m);
        println();

        if(colCount <= lead)
        {
            quit = true;
            break;
        }

        i=row;

        while(!quit && m[i][lead] == 0)
        {
            i++;
            if(rowCount == i)
            {
                i=row;
                lead++;

                if(colCount == lead)
                {
                    quit = true;
                    break;
                }
            }
        }

        if(!quit)
        {
            swapRows(m, i, row);

            if(m[row][lead] != 0)
                multiplyRow(m, row, 1.0f / m[row][lead]);

            for(i = 0; i < rowCount; i++)
            {
                if(i != row)
                    subtractRows(m, m[i][lead], row, i);
            }
        }
    }
}

// swaps two rows
static void swapRows(double [][] m, int row1, int row2)
{
    double [] swap = new double[m[0].length];

    for(int c1 = 0; c1 < m[0].length; c1++)
        swap[c1] = m[row1][c1];

    for(int c1 = 0; c1 < m[0].length; c1++)
    {
        m[row1][c1] = m[row2][c1];
        m[row2][c1] = swap[c1];
    }
}

static void multiplyRow(double [][] m, int row, double scalar)
{
    for(int c1 = 0; c1 < m[0].length; c1++)
        m[row][c1] *= scalar;
}

static void subtractRows(double [][] m, double scalar, int subtract_scalar_times_this_row, int from_this_row)
{
    for(int c1 = 0; c1 < m[0].length; c1++)
        m[from_this_row][c1] -= scalar * m[subtract_scalar_times_this_row][c1];
}

static public void print(double [][] matrix)
{
    for(int c1 = 0; c1 < matrix.length; c1++)
    {
        System.out.print("[ ");

        for(int c2 = 0; c2 < matrix[0].length-1; c2++)
            System.out.print(matrix[c1][c2] + ", ");

        System.out.println(matrix[c1][matrix[c1].length-1] + " ]");
    }
}

//RREF code above ---> gotten from stack overflow

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


String ans = "";

//need a within radius functions
Element holdera;

//These are the holder vectors for the gui
int counter = -1;
ArrayList<junction> junctions = new ArrayList<junction>();
//above well use these arraylists for junctions
ArrayList<Component> components = new ArrayList<Component>();
ArrayList<Component> sources = new ArrayList<Component>();
ArrayList<ArrayList<junction>> nodes = new ArrayList<ArrayList<junction>>();
//this has to be an element otherwise we wont be able to add wires

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
      for (Element e : j.terminals) {
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
  
  text("Number of nodes: "+nodes.size(), 770, 600, 100, 100);

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
      String value = showInputDialog("How many ohms of resistance would you like? ");
      float val = Float.parseFloat(value);
      Resistor r = new Resistor(x, y, x + 80, y, val);
      if (rot) r.rotate();
      junctions.add(r.a);
      junctions.add(r.b);
      r.place();
      r.display();
      //System.out.println("test");
      components.add(r);
      
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
      String value = showInputDialog("How many volts would you like? ");
      float val = Float.parseFloat(value);
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

      boolean makeNode = true;
      for (ArrayList<junction> n : nodes) {
        for (junction j : n) {
          if (rounder(j.x) == rounder(w.a.x)
          && rounder(j.y) == rounder(w.a.y)) {
            j.merge(w.a);
            makeNode = false;
          }
          if (rounder(j.x) == rounder(w.b.x)
          && rounder(j.y) == rounder(w.b.y)) {
            j.merge(w.b);
            makeNode = false;
          }
        }
      }
      if (makeNode) {
        ArrayList<junction> newNode = new ArrayList<junction>();
        newNode.add(w.a);
        newNode.add(w.b);
        nodes.add(newNode);
      }
      updateMatrix = true;
      w.display();
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
