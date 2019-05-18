public class Node extends Element{
  private float voltage;
  private float verticies;
  private Element in;
  private Element out;
  private float x = super.getX();
  private float y = super.getY();
 
  //we forgot to add the in and out to the uml
  public float voltage(){
    return in.voltage();
  }
  
  public float current(){
    return in.current();
    //Later we will have to fix this and calculate current for the whole curcuit
  }
  
  
  public void display(){
     polygon(x,y,5,6);
  }
  
  public boolean placed(){
    return super.placed();
  }
  

  
  
  
  
  
  
  
  
 
  
  
}




//This is just to help us draw stuff
void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
