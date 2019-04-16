class BaseFacade

  include LocationHelper

  private

  def request_weather(coordinates)
    @weather ||= WeatherService.new(coordinates).get_forecast
  end

  def request_photograph(location)
    @photo_info ||= PhotoService.new(location).get_photo
  end

  def request_location
    location = City.find_by(name: "#{@city}, #{@state}".strip)
    unless location
      location = create_new_location(@city, @state)
    end
    location.coordinates
  end
end
