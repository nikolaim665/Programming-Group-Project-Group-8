class Filter
{
    public final String carrierCodePrefix, minDate, maxDate;

    public Filter(String carrierCodePrefix, String minDate, String maxDate)
    {
        this.carrierCodePrefix = carrierCodePrefix;
        this.minDate = minDate;
        this.maxDate = maxDate;
    }

    public Filter()
    {
        this("", "0000-00-00", "9999-99-99");
    }
    
    public boolean matches(Flight flight)
    {
        return flight.carrierCode.startsWith(carrierCodePrefix) 
            && flight.flightDate.compareTo(minDate) >= 0
            && flight.flightDate.compareTo(maxDate) <= 0;
    }

    public boolean equals(Filter another)
    {
        return carrierCodePrefix.equals(another.carrierCodePrefix)
            && minDate.equals(another.minDate)
            && maxDate.equals(another.maxDate);
    }
}