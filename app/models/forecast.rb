class Forecast
  attr_reader :city,
              :state

  def initialize(location_args)
    @city = location_args[:city]
    @state = location_args[:state]
  end

  def id
    "#{@city}, #{@state}"
  end

  def current_weather
    CurrentForecast.new({})
  end

  def hourly_forecasts
    []
  end

  def daily_forecasts
    []
  end
end
