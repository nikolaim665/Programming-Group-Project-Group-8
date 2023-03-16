final int INITIAL_WIDGET_YPOSITION = 40;
final int WIDGET_WIDTH = 80;
final int WIDGET_HEIGHT = 30;

class Widget {
  public int xPosition;
  public int yPosition;
  //public String name;
  
  public int colour; //colour will be stored as hex value
  public String widget_label;
  public boolean displayWidgetOutline;
  
  public void drawWidget() {
    
    if (this.displayWidgetOutline)
      stroke(220);
    else
      noStroke();
    
    
    fill(this.colour); rect(this.xPosition, this.yPosition, WIDGET_WIDTH, WIDGET_HEIGHT);
    fill(255);
    text(this.widget_label, this.xPosition + WIDGET_WIDTH/4, this.yPosition + WIDGET_HEIGHT/2);
    
    //this.displayWidgetOutline=false;
    
  }
  
  public boolean checkIfMouseIsHoveringOverWidget() {
    if (this.yPosition < mouseY && mouseY < (this.yPosition+WIDGET_HEIGHT)) {
      if (this.xPosition < mouseX && mouseX < (this.xPosition+WIDGET_WIDTH)) {
        return true;
      }
    }
    
    return false; 

  }
  /*
  public void addWidget(Widget w, int i) {
    
      w.xPosition = width/2 - (WIDGET_WIDTH/2);
      w.yPosition = (i* (WIDGET_HEIGHT*2)) + INITIAL_WIDGET_YPOSITION;
      w.colour = colours[i];
      w.widget_label = widget_labels[i];
      w.displayWidgetOutline = false;
    
    
    
  }
  */
  
}
