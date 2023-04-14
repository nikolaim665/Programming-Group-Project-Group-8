// Class encapsulating all the filtering criteria, to make it easy to add new criteria
// and to pass the Filter object around without having to deal with its contents
class Filter
{
  private final String carrierCode, city;
  private final String airportFrom, airportTo;
  private final int minDate, maxDate;

  public Filter(String carrierCode, String city, String airportFrom, String airportTo, int minDate, int maxDate)
  {
    this.carrierCode = carrierCode.toUpperCase();
    this.city = city.toLowerCase();
    this.airportFrom = airportFrom;
    this.airportTo = airportTo;
    this.minDate = minDate;
    this.maxDate = maxDate;
  }

  public Filter()
  {
    this("", "", "", "", 0, 0x7FFF_FFFF);
  }
  
  public boolean matches(Flight flight)
  {
    boolean cityName = flight.destinationCityName.toLowerCase().startsWith(city) || flight.originCityName.toLowerCase().startsWith(city);
    boolean carrier = flight.carrierCode.startsWith(carrierCode);
    boolean airport = flight.destinationAirportCode.startsWith(airportTo) && flight.originAirportCode.startsWith(airportFrom);
    boolean date = flight.flightDate >= minDate && flight.flightDate <= maxDate;
    return cityName && carrier && airport && date;
  }

  public boolean equals(Filter another)
  {
    return city.equals(another.city) && carrierCode.equals(another.carrierCode)
        && airportTo.equals(another.airportTo) && airportFrom.equals(another.airportFrom)
        && minDate == another.minDate && maxDate == another.maxDate;
  }
}
