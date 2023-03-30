int[] airportColours = {#FFC1FF, #0000CF, #CC0099}; //pink, dark blue, purple


//very similar to state data, but will do a pareto chart

class Airport {
  int numberOfIncomingFlights;
  int numberOfOutgoingFlights;
  int cumulativeNumberOfFlights;// = numberOfIncomingFlights+numberOfOutgoingFlights;
  int xPosition;
  int yPosition;
  
  String code;     
  int barChartColour;     
  
  public Airport(String abbrev, int incoming, int outgoing, int colour, int xpos, int ypos) {
    this.numberOfIncomingFlights = incoming;
    this.numberOfOutgoingFlights = outgoing;
    this.code = abbrev;
    this.barChartColour = colour;  //to distinguish one bar from another
    
    this.xPosition = xpos;
    this.yPosition = ypos;
    
  }


}

ArrayList<String> airportNames = new ArrayList<String>();
ArrayList<Airport> airports = new ArrayList<Airport>();         //airports will contain all the data, airportNames will be used for more efficient sorting (i think)

void createListOfAirports(ArrayList<Flight> flights) {
  
  for (int i =0; i<flights.size(); i++) {
    
    
    String originAirport = flights.get(i).originAirportCode;
    String destinationAirport = flights.get(i).destinationAirportCode;
    
    int finished =0;
    //if both instance variables of airport have been assigned, terminate loop
    
    boolean originAirportListed=false;
    boolean destinationAirportListed=false;
    
    
    for (int k=0; k<airportNames.size() && finished<2; k++) {
      if (airportNames.get(k).equals(originAirport) ) {
        originAirportListed=true;
        finished++;
      }
      else if (airportNames.get(k).equals(destinationAirport) ) {
        destinationAirportListed=true;
        finished++;
      }
      
    }
    
    
    if (!originAirportListed) {
      airportNames.add(originAirport);
    } else if (!destinationAirportListed){
      airportNames.add(destinationAirport);
    }
   
  }
  
  for (int j=0; j<airportNames.size();j++) {
    //will not colour airport bars now anyway since it will be re-coloured later anyway      
    airports.add(new Airport(airportNames.get(j), 0, 0, 0, 0, 0) );
  }
  
  assignFlightsToAirports(flights);
  sortAirports();
  
  
  
  
}

void assignFlightsToAirports(ArrayList<Flight> flights) {
  

  
  for (int i =0; i<flights.size(); i++) {
    
    String originAirport = flights.get(i).originAirportCode;
    String destinationAirport = flights.get(i).destinationAirportCode;
    
    int finished=0;
      
    for (int j=0; j<airports.size() && finished<2; j++) {
      
    
    if (airports.get(j).code.equals(originAirport) ) { //.equals(destinationState)
        airports.get(j).numberOfOutgoingFlights++;
        finished++;
      }
      else if (airports.get(j).code.equals(destinationAirport) ){
        airports.get(j).numberOfIncomingFlights++;
        finished++;
      }
      
    }
    
    
  }
  
}
  

  
  //System.out.println(airports.get(5).cumulativeNumberOfFlights);
  //System.out.println(airports.get(5).numberOfIncomingFlights);
  //System.out.println(airports.get(5).numberOfOutgoingFlights);
  
  
  //System.out.println(airports.size()); 369 airports (in 2k sheet)
  
  //System.out.println(mostIncoming.code);        //max incoming == 25,464
  //System.out.println(mostOutgoing.code);        //max outgoing == 25,480
  //System.out.println(mostCumulative.code);      //max cumulative == 50944
