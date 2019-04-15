class Antipode
  attr_reader :search_location,
              :location_name

  def initialize(location_info)
    @city = location_info[:city]
    @search_location = geocode_city
    @search_coordinates = geocode_coordinates
    @location_name = request_antipode
    @forecast = get_antipode_forecast
  end

  private

  def request_antipode
    antipode_service.get_antipode(@search_coordinates)
  end

  def get_antipode_forecast

  end

  def geocode_coordinates
    geocode_location[:geometry]
  end

  def geocode_city
    geocode_location[:formatted_address]
  end

  def geocode_location
    @location ||= geocode_service.get_location(@city)
  end

  def geocode_service
    @service ||= GeocodeService.new
  end
end

# Steps: Geocode City, store result name
# Feed into Instructor API
# Reverse Geocode Result
# Feed In to WeatherService
