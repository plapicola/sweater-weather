class Antipode
  attr_reader :search_location,
              :location_name

  def initialize(location_info)
    @city = location_info[:city]
    @search_location = geocode_city
    @search_coordinates = geocode_coordinates
    @antipode_coordinates = request_antipode
    @location_name = reverse_geocode
    @forecast = get_antipode_forecast
  end

  private

  def request_antipode
    antipode_service.get_antipode(@search_coordinates)
  end

  def get_antipode_forecast
    CurrentWeather.from_request(weather_service.request_forecast)
  end

  def geocode_coordinates
    geocode_location[:geometry][:location]
  end

  def geocode_city
    geocode_location[:formatted_address]
  end

  def reverse_geocode
    geocode_service.reverse_geocode(@antipode_coordinates)
  end

  def geocode_location
    @location ||= geocode_service.get_location(@city)
  end

  def geocode_service
    @geocode ||= GeocodeService.new
  end

  def antipode_service
    @antipode ||= AntipodeService.new
  end

  def weather_service
    @weather ||= WeatherService.new(@antipode_coordinates)
  end
end

# Steps: Geocode City, store result name
# Feed into Instructor API
# Reverse Geocode Result
# Feed In to WeatherService
