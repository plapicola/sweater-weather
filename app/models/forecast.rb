class Forecast
  attr_reader :city,
              :state,
              :current_weather,
              :hourly_forecasts,
              :daily_forecasts

  def initialize(location_args)
    @city = location_args[:city]
    @state = location_args[:state]
    populate_weather
  end

  def id
    "#{@city}, #{@state}"
  end

  alias name id

  private

  def populate_weather
    @current_weather = CurrentWeather.from_request(request_weather(request_location))
    @hourly_forecasts = HourlyWeather.from_request(request_weather(request_location))
    @daily_forecasts = DailyWeather.from_request(request_weather(request_location))
  end

  def request_location
    @coordinates ||= GeocodeService.new.get_coordinates(@city, @state)
  end

  def request_weather(coordinates)
    @weather ||= WeatherService.new(coordinates).get_forecast
  end

end
