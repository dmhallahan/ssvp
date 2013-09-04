module Tools

require 'csv'
require 'net/http'

#takes an string address and returns the latitude and longitude as array, or nil on fail
def get_latlng(address)
    
  if RAILS_ROOT == 'C://Rails/ssvp'
    api_key = "ABQIAAAAzr2EBOXUKnm_jVnk0OJI7xSosDVG8KKPE1-m51RBrvYughuyMxQ-i1QfUnH94QxWIa6N4U6MouMmBA"
  else
    api_key = "ABQIAAAAKxdghs44-6Zbwux-M2j8PxQM_5f4oJ3bX2DkBRFzPOOnN9rvxhRVhIPXANGZpGerQlbk-Qjqi8TWfQ";
  end
  
    map_params = {}
    map_params["q"] = address.gsub(" ", "+") #format spaces for url
    map_params["key"] = api_key
    map_params["sensor"] = 'false'
    map_params["output"] = 'csv'
    
    
    params = map_params.to_a
    param_string = params.collect {|a| a.join("=")}
    str = param_string.join("&")
    url = "http://maps.google.com/maps/geo?"+str

   res = Net::HTTP.get(URI.parse(url))
   a = CSV.parse_line(res) #parse csv values to array
   status = a[0].to_i
   lat = a[2]
   lon = a[3]
   
   if status == 200
    response = [lat, lon]
  else
    response = nil
  end
end

end