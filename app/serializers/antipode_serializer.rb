class AntipodeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :location_name

  meta do |antipode|
    {
      search_location: antipode.search_location
    }
  end

  attribute :forecast do |obj|
    {
      summary: obj.forecast.current_weather,
      current_temperature: obj.forecast.current_temperature
    }
  end
end
