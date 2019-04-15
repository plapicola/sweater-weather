class Antipode
  def initialize(location_info)
    @city = location_info[:city]
    @search_location =
    @antipode_location =
    @forecast = get_antipode_forecast
  end

  private

  def get_antipode_forecast
  end

  def request_location
    geocode_service.get_coordinates(@city)
  end

  def geocode_service
    @service
end

# Steps: Geocode City, store result name
# Feed into Instructor API
# Reverse Geocode Result
# Feed In to WeatherService
