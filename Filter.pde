class Filter
{
  public final String city;
  public final String airportFrom, airportTo;
  public final int minDate, maxDate;

  public Filter(String city, String airportFrom, String airportTo, int minDate, int maxDate)
  {
    this.city = city.toLowerCase();
    this.airportFrom = airportFrom;
    this.airportTo = airportTo;
    this.minDate = minDate;
    this.maxDate = maxDate;
  }

  public Filter()
  {
    this("", "", "", 0, 0x7FFF_FFFF);
  }
  
  public boolean matches(Flight flight)
  {
    return (flight.destinationCityName.toLowerCase().startsWith(city) || flight.originCityName.toLowerCase().startsWith(city))
        && (flight.destinationAirportCode.startsWith(airportTo) && flight.originAirportCode.startsWith(airportFrom))
        && (flight.flightDate >= minDate && flight.flightDate <= maxDate);
  }

  public boolean equals(Filter another)
  {
    return city.equals(another.city)
        && airportTo.equals(another.airportTo) && airportFrom.equals(another.airportFrom)
        && minDate == another.minDate && maxDate == another.maxDate;
  }
}
