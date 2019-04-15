class Antipode
  def initialize(location_info)
    @city = location_info[:city]
    @search_location = geocode_city
    @search_coordinates = geocode_coordinates[
    @antipode_location = request_anti
    @forecast = get_antipode_forecast
  end

  private

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
