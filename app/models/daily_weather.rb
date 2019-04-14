class DailyWeather
  attr_reader :id,
              :day,
              :weather,
              :percipitation_chance,
              :max_temperature,
              :min_temperature

  def initialize(weather_info)
    @id = weather_info[:id]
    @day = weather_info[:day]
    @weather = weather_info[:weather]
    @percipitation_chance = weather_info[:percipitation_chance]
    @max_temperature = weather_info[:max_temperature]
    @min_temperature = weather_info[:min_temperature]
  end

  def self.from_request(request)
    request[:daily][:data].map do |weather_info|
      new({
        id: weather_info[:time],
        day: Time.at(weather_info[:time]).strftime('%A'),
        weather: weather_info[:summary],
        percipitation_chance: weather_info[:precipProbability],
        max_temperature: weather_info[:temperatureHigh],
        min_temperature: weather_info[:temperatureLow]
      })
    end
  end
end
