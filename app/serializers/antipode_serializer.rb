class AntipodeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location_name, :search_location

  attribute :forecast do |obj|
    CurrentWeatherSerializer.new(obj.forecast)
  end
end
