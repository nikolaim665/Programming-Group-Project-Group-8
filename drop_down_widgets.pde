// this will do a drop down menu when you click on certain buttons

// if you're going to erase all of my work and replace it with your own, please text me first
// because that already happened with one of my files

int WIDGET_WIDTH = 120;
int WIDGET_HEIGHT = 30;

boolean dropDownWidgetsCanBePressed;

ArrayList<Widget> stateWidgets;
//ArrayList<Widget> airportWidgets;

Widget[] airportWidgets = new Widget[widget_labels.length];

class Widget {
  public int xPosition;
  public int yPosition;
  
  public int colour; //colour will be stored as hex value
  public String widget_label;
  public String widget_function;
  public boolean displayWidgetOutline;
  
  public void drawWidget() {
    
    if (this.checkIfMouseIsHoveringOverWidget())
      stroke(255);
    else
      stroke(0);
    
    
    fill(this.colour); rect(this.xPosition, this.yPosition, WIDGET_WIDTH, WIDGET_HEIGHT);
    fill(0);
    text(this.widget_label, this.xPosition + WIDGET_WIDTH/6, this.yPosition + WIDGET_HEIGHT/4);

    
  }
  
  public boolean checkIfMouseIsHoveringOverWidget() {
    if (this.yPosition < mouseY && mouseY < (this.yPosition+WIDGET_HEIGHT)) {
      if (this.xPosition < mouseX && mouseX < (this.xPosition+WIDGET_WIDTH)) {
        return true;
      }
    }
    
    return false; 

  }
  
  
}

void createDropDownWidgets() {
  dropDownWidgetsCanBePressed = false;
  
  
    for (int i =0; i<3; i++) {
      Widget w = new Widget();
    
      w.xPosition =  1153;
      w.yPosition = (i* WIDGET_HEIGHT) + 40;//INITIAL_BUTTON_YPOSITION;
      
      //tbc^
      w.colour = dropDownButtonColours[i];
      w.widget_label = widget_labels[i];
      w.widget_function = widget_functions[i];
      
      w.displayWidgetOutline = false;      
      
      airportWidgets[i] = w;
    } 
    
    
    for (int i =0; i<3; i++) {
      Widget w = new Widget();
    
      w.xPosition =  1262;
      w.yPosition = (i* (WIDGET_HEIGHT*2)) + 40;//INITIAL_BUTTON_YPOSITION;
      
      //tbc^
      w.colour = dropDownButtonColours[i];
      w.widget_label = widget_labels[i];
      w.displayWidgetOutline = false;
      
      
      //stateWidgets.get(0) = w;
    } 

  }
  
  
  
  
void drawDropDownWidgets(Widget[] widgets) {
  dropDownWidgetsCanBePressed = true;
  
  for (int i=0; i<widgets.length; i++) {
    widgets[i].drawWidget();
  }
  
}
