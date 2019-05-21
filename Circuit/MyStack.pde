import java.util.*;

public class MyStack {
  private float[] data;
  private int start, end;
  
  public MyStack() {
    data = new float[10];
  }
  
  public int getSize() {
    return mod(end - start);
  }
  
  public void addFirst(float value) {
    if (getSize() >= data.length - 1) resize();
    start = mod(start - 1);
    data[start] = value;
  }
  
  public void addLast(float value) {
    if (getSize() >= data.length - 1) resize();
    data[end] = value;
    end = mod(end+1);
  }
  
  public float removeFirst() {
    if (getSize() == 0) throw new NoSuchElementException();
    start = mod(start + 1);
    return data[mod(start-1)];
  }

  public float removeLast() {
    if (getSize() == 0) throw new NoSuchElementException();
    end = mod(end - 1);
    return data[end];
  }
  
    public float getFirst() {
    if (getSize() == 0) throw new NoSuchElementException();
    return data[start];
  }

  public float getLast() {
    if (getSize() == 0) throw new NoSuchElementException();
    return data[mod(end-1)];
  }
    
  private int mod(int x) {
    return (x + data.length) % data.length;
  }
  
  private void resize() {
    float[] temp = new float[data.length * 2 + 1];
    for (int i = 0; i < data.length; i++) {
      temp[i] = data[mod(start+i)];
    }
    end = getSize();
    start = 0;
    data = temp;
  }
}
