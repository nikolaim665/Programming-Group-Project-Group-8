class Filter
{
  public final String cityPrefix;
  public final String airportFrom, airportTo;
  public final int minDate, maxDate;

  public Filter(String cityPrefix, String airportFrom, String airportTo, int minDate, int maxDate)
  {
    this.cityPrefix = cityPrefix;
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
    return (flight.destinationCityName.startsWith(cityPrefix) || flight.originCityName.startsWith(cityPrefix))
        && (flight.destinationAirportCode.startsWith(airportTo) && flight.originAirportCode.startsWith(airportFrom))
        && (flight.flightDate >= minDate && flight.flightDate <= maxDate);
  }

  public boolean equals(Filter another)
  {
    return cityPrefix.equals(another.cityPrefix)
        && airportTo.equals(another.airportTo) && airportFrom.equals(another.airportFrom)
        && minDate == another.minDate && maxDate == another.maxDate;
  }

  public Filter withDateRange(int minimum, int maximum)
  {
    return new Filter(cityPrefix, airportFrom, airportTo, minimum, maximum);
  }

  public Filter withCityPrefix(String newPrefix)
  {
    return new Filter(newPrefix, airportFrom, airportTo, minDate, maxDate);
  }

  public Filter withAirports(String from, String to)
  {
    return new Filter(cityPrefix, from, to, minDate, maxDate);
  }
}
