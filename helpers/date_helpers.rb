def format_date date
  date.strftime '%b %e, %Y'
end

# Generate an ISO 8601 representation of the specified date expressed in UTC.
def to_datetime date
  #date.getutc.strftime('%FT%T%:z')
  date.getutc.iso8601
end
