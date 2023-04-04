// draw airports pareto barchart
//to do so, airports need to be in highest-to-lowest order


//READ --------------
//ordered Incoming Flights Of Airports  is a highest-to-lowest ArrayList  of airports with the highest number incoming flights first, and lowest last
//same goes for  orderedOutgoingFlightsOfAirports  and  orderedCumulativeFlightsOfAirports

//you don't need to call sortAirports()

ArrayList<Airport> orderedIncomingFlightsOfAirports= new ArrayList<Airport>();
ArrayList<Airport> orderedOutgoingFlightsOfAirports= new ArrayList<Airport>();

ArrayList<Airport> orderedCumulativeFlightsOfAirports= new ArrayList<Airport>();


void sortAirports() {
  
  //mf = mostFlights, ie, mostIncoming/OutgoingFlights
  
  ArrayList<Airport> temp = copyAirportList(airports);  
  
  int numOfAirports = airports.size(); //airports.size will be altered
  
  //sort incoming flights
    for (int i=0; i<numOfAirports; i++) {
     Airport mf = temp.get(0);
     
      for (int j=0; j<temp.size(); j++) {
        
      if (mf.numberOfIncomingFlights < temp.get(j).numberOfIncomingFlights)
        mf = temp.get(j);
      
      }
  
      orderedIncomingFlightsOfAirports.add(mf);
      temp.remove(mf);
    }
    
    ArrayList<Airport> temp2 = copyAirportList(airports); //restore airports
    
    
    //sort outgoing flights
    for (int i=0; i<numOfAirports; i++) {
     Airport mf = temp2.get(0);
     
      for (int j=0; j<temp2.size(); j++) {
        
      if (mf.numberOfOutgoingFlights < temp2.get(j).numberOfOutgoingFlights)
        mf = temp2.get(j);
      }
  
      orderedOutgoingFlightsOfAirports.add(mf);
      temp2.remove(mf);
    }
    
    ArrayList<Airport> temp3 = copyAirportList(airports); //restore airports
    
    //sort cumulative flights
    for (int i=0; i<numOfAirports; i++) {
     Airport mf = temp3.get(0);
     
      for (int j=0; j<temp3.size(); j++) {
        
      if (mf.cumulativeNumberOfFlights < temp3.get(j).cumulativeNumberOfFlights)
        mf = temp3.get(j);
      }
  
      orderedCumulativeFlightsOfAirports.add(mf);
      temp3.remove(mf);
    }
    
    
    
    //re arrange colours
    int c=0; //c=colour of bar
    for (int j=0; j<numOfAirports; j++, c++) {
        if (c==3)
          c=0;
         
         //are these all pointing to the same objects?
         orderedIncomingFlightsOfAirports.get(j).barChartColour=airportColours[c];
         orderedOutgoingFlightsOfAirports.get(j).barChartColour=airportColours[c];
         orderedCumulativeFlightsOfAirports.get(j).barChartColour=airportColours[c];
               
    }
    
    println(orderedIncomingFlightsOfAirports.get(0).numberOfIncomingFlights);
  
}


ArrayList<Airport> copyAirportList(ArrayList<Airport> airports) {  //creates a replaceable copy of airports
  ArrayList<Airport> temp = new ArrayList<Airport>();
  
  for (int i=0; i<airports.size(); i++) {
    Airport a = new Airport( airports.get(i).code ,airports.get(i).numberOfIncomingFlights, airports.get(i).numberOfOutgoingFlights, 
                          airports.get(i).barChartColour, airports.get(i).xPosition, airports.get(i).yPosition);
    a.cumulativeNumberOfFlights = a.numberOfIncomingFlights + a.numberOfOutgoingFlights;
    temp.add(a);
  }
  
  return temp;
  
}




void determineTypeOfAirportBarchart(String flightType) {
  
 
  
  
  if (flightType.equals("Incoming"))
    drawAirportChart(30000, 7, "Incoming");
  else if (flightType.equals("Outgoing"))
    drawAirportChart(30000, 7, "Outgoing");
  else if (flightType.equals("Cumulative"))
    drawAirportChart(55000, 12, "Cumulative");
  
}




void drawAirportChart(int maxFlights, int numberOfMarkers, String flightType) {
  
  
  //max height of chart == 450 (-30 for labelling x-axis)
  //max width of chart == 738 (num of airports == 738)
  //xpos = 690 (+50 for labelling y-axis) 
  //ypos = 50
    
  
  int barChartHeight = 420;
  int barChartWidth = 738;
  
  int xPosition = 750;  //xpos of barchart
  int yPosition = 50;
  
  //drawing axes
  fill(0); stroke(0);
  rect(xPosition, yPosition, 2, barChartHeight);
  rect(xPosition, yPosition+barChartHeight, barChartWidth, 2);
  
  //draw number markers
  
  //max outgoing from one state== 59,129
  
  //draw markers for x axis
  for (int i=0; i<numberOfMarkers;i++ ) {
    int textXPos = xPosition - 60;
    int markerXPos = xPosition - 10;
    
    int text = maxFlights - (i*5000);
    int spaceBetweenMarkers = barChartHeight/(numberOfMarkers-1);
    int markerYPos = yPosition + (i*spaceBetweenMarkers);
    
    fill(0); stroke(0);
    rect(markerXPos, markerYPos, 10, 1);  //for y axis, width =10, length = 1
    
    if (text<0)
      text(0, textXPos, markerYPos);
    else
      text(text, textXPos, markerYPos);
  }
  
  
  int numberOfAirports = airports.size();
  int barWidth = 4;   //barChartWidth/numberOfAirports;
  
  
  for ( int i=0; i<numberOfAirports;i++ ) {        //for x axis, width = 1, length = 10
    
    int markerXPos = xPosition+3 + (i*barWidth); //+3 is for better placement on graph
    float markerYPos = yPosition+barChartHeight;
  
    //text(text, markerXPos, textYPos);
    //textFont(font, 16);
    
    //need to make rectangle related to barchart height
    int flights =1;
    int barChartColour = #000000;
    String airportCode = "TBC";
    
      if (flightType.equals("Incoming")) {
        flights = orderedIncomingFlightsOfAirports.get(i).numberOfIncomingFlights; //determines whether we want outgoing, incoming or cumu flights
        barChartColour = orderedIncomingFlightsOfAirports.get(i).barChartColour;
        airportCode = orderedIncomingFlightsOfAirports.get(i).code;
      }
      else if (flightType.equals("Outgoing")) {
        flights = orderedOutgoingFlightsOfAirports.get(i).numberOfOutgoingFlights;
        barChartColour = orderedOutgoingFlightsOfAirports.get(i).barChartColour;
        airportCode = orderedOutgoingFlightsOfAirports.get(i).code;
      } 
      else if (flightType.equals("Cumulative")) {
        flights = orderedCumulativeFlightsOfAirports.get(i).cumulativeNumberOfFlights;
        barChartColour = orderedCumulativeFlightsOfAirports.get(i).barChartColour;
        airportCode = orderedCumulativeFlightsOfAirports.get(i).code;
      }
     
      
      
    

    
    float heightOfBar = barChartHeight * (flights); 
    heightOfBar /= maxFlights; // if a airport has 30,000 flights coming in, the bar will fill halfway
    
    
    int roundedHeightOfBar = round(heightOfBar);
    fill(barChartColour); //stroke(0);
    
    

    
    rect(markerXPos, (markerYPos), barWidth, -roundedHeightOfBar);
    displayCurrentAirport(markerXPos, markerYPos, barWidth, roundedHeightOfBar, airportCode, i);
  }
  
  //System.out.println(totalPercentageOfAirports +" "+ orderedAirports.size() + " " + numberOfAirports);
  
  
  
  
  
}
PFont font;
void displayCurrentAirport(int x, float y, int w, int h, String airportCode, int totalPercentageOfAirports) {
  
  if (x < mouseX && mouseX< x+w) {
    if(y-h <mouseY && mouseY< y) {
      
      font = createFont("Arial",30,true);
      //textFont(font, 30);
      fill(0);
      text(airportCode, 1200, 275 ); //int barChartHeight = 420;
                                   //int barChartWidth = 450;
      float temp = totalPercentageOfAirports * 100;
      temp/=738;    //orderedAirports.size();
      text(totalPercentageOfAirports, 1200, 205 );
      text(temp +"% of all flights", 1200, 325 );                   
              //750+ 450, 50+(barChartHeight/2)
                                   //int xPosition = 750;  //xpos of barchart
                                   //int yPosition = 50;
      textFont(font, 16);
    }
  }
  
  
  
  
  
  
  
}
