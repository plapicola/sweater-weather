class CurrentWeather
  attr_reader :current_temperature,
              :perceived_temperature,
              :max_temperature,
              :min_temperature,
              :current_weather,
              :humidity,
              :visibility,
              :uv_index,
              :current_description,
              :future_description

  def initialize(weather_info)
    @current_temperature = weather_info[:current_temperature]
    @perceived_temperature = weather_info[:perceived_temperature]
    @max_temperature = weather_info[:max_temperature]
    @min_temperature = weather_info[:min_temperature]
    @current_weather = weather_info[:current_weather]
    @humidity = weather_info[:humidity]
    @visibility = weather_info[:visibility]
    @uv_index = weather_info[:uv_index]
    @current_description = weather_info[:current_description]
    @future_description = weather_info[:future_description]
  end

  def self.from_request(request)
    new({
      current_temperature: request[:currently][:temperature],
      perceived_temperature: request[:currently][:apparentTemperature],
      max_temperature: request[:daily][:data][0][:temperatureHigh],
      min_temperature: request[:daily][:data][0][:temperatureLow],
      current_weather: request[:currently][:summary],
      humidity: request[:currently][:humidity],
      visibility: request[:currently][:visibility],
      uv_index: request[:currently][:uvIndex],
      current_description: request[:currently][:summary],
      future_description: request[:hourly][:data][11][:summary]
    })
  end
end
