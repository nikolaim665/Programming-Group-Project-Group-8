<<<<<<< HEAD
import java.util.ArrayList; //has this already been imported?

final int NUMBER_OF_SCREENS = 6; //how many charts will we have?
=======
import java.util.ArrayList;

final int NUMBER_OF_SCREENS = 6;
>>>>>>> 2d34449ec42599c8fc15c3ee6ba208ff569a1434

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

<<<<<<< HEAD



//to be called in setup()
=======
>>>>>>> 2d34449ec42599c8fc15c3ee6ba208ff569a1434
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
  
<<<<<<< HEAD
=======
    currentScreenBackground = screens.get(0).backgroundColour;
  
>>>>>>> 2d34449ec42599c8fc15c3ee6ba208ff569a1434
  
}
