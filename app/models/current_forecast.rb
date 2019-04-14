class CurrentForecast
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
end
