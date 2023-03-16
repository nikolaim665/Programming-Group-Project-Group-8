import java.util.ArrayList;

final int NUMBER_OF_SCREENS = 6;

final int[] colours = {#FF0000, #00FF00, #0000FF}; //red, green, blue
final String[] widget_labels = {"BUTTON", "FORWARD", "BACKWARD"};

ArrayList<Screen> screens;
int currentScreen; //if ==0, in the first screen, if ==1, in the second screen
int currentScreenBackground;


class Screen {
  
  ArrayList<Widget> widgets;
  int numberOfWidgets;
  int backgroundColour;
  
}

public void createScreens() {
  
  screens = new ArrayList<Screen>();
  currentScreen=0;
  
  for (int j =0; j<NUMBER_OF_SCREENS; j++) {
    Screen screen = new Screen();
    ArrayList<Widget> widgets = new ArrayList<Widget>();
    screen.widgets = widgets;
    //fill(134); rect (80, 80, 80, 80);
    //widgets.add(new Widget());
  
    for (int i =0; i<3; i++) {
      //widgets.add(new Widget());
      Widget w = new Widget();
    
      w.xPosition = width/2 - (WIDGET_WIDTH/2);
      w.yPosition = (i* (WIDGET_HEIGHT*2)) + INITIAL_WIDGET_YPOSITION;
      w.colour = colours[i];
      w.widget_label = widget_labels[i];
      w.displayWidgetOutline = false;      
    
      screen.widgets.add(w);
      screen.numberOfWidgets++;
    
    }
    
    int n = j+1; //naming buttons, if on screen[0], button will be called button n, ie, button 1
    String tempName = Integer.toString(n);
    screen.widgets.get(0).widget_label += tempName;
    screen.backgroundColour= j*75;
    screens.add(screen);
  
  }
  
    currentScreenBackground = screens.get(0).backgroundColour;
  
  
}
