class Filter
{
    public final String carrierCodePrefix;
    public final int minDate, maxDate;

    public Filter(String carrierCodePrefix, int minDate, int maxDate)
    {
        this.carrierCodePrefix = carrierCodePrefix;
        this.minDate = minDate;
        this.maxDate = maxDate;
    }

    public Filter()
    {
        this("", 0, 0x7FFF_FFFF);
    }
    
    public boolean matches(Flight flight)
    {
        return flight.carrierCode.startsWith(carrierCodePrefix) 
            && flight.flightDate >= minDate
            && flight.flightDate <= maxDate;
    }

    public boolean equals(Filter another)
    {
        return carrierCodePrefix.equals(another.carrierCodePrefix)
            && minDate == another.minDate
            && maxDate == another.maxDate;
    }
}
