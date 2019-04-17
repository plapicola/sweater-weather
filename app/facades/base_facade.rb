class BaseFacade

  include LocationHelper

  private

  def request_weather(coordinates)
    cache_key = "#{coordinates}/#{Time.now.hour}/request_weather"
    Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      @weather ||= WeatherService.new(coordinates).get_forecast
    end
  end

  def request_photograph(coordinates)
    cache_key = "#{coordinates}/#{Time.now.month}/request_photograph"
    Rails.cache.fetch(cache_key, expires_in: 1.month) do
      @photo_info ||= PhotoService.new(coordinates).get_photo
    end
  end

  def request_location
    location = City.find_by(name: "#{@city}, #{@state}".strip)
    unless location
      location = create_new_location(@city, @state)
    end
    location.coordinates
  end
end
