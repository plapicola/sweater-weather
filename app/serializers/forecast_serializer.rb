class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  attribute :current_weather do |obj|
    CurrentWeatherSerializer.new(obj.current_weather)
  end

  attribute :hourly_forecasts do |obj|
    HourlyWeatherSerializer.new(obj.hourly_forecasts)
  end

  attribute :daily_forecasts do |obj|
    DailyWeatherSerializer.new(obj.daily_forecasts)
  end
end
