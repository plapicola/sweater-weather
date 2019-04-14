class HourlyWeather
  attr_reader :id,
              :hour,
              :temperature,
              :weather

  def initialize(weather_info)
    @id = weather_info[:id]
    @hour = weather_info[:hour]
    @temperature = weather_info[:temperature]
    @weather = weather_info[:weather]
  end

  def self.from_request(request)
    request[:hourly][:data].map do |request_info|
      new({
        id: request_info[:time],
        hour: Time.at(request_info[:time]).hour,
        temperature: request_info[:temperature],
        weather: request_info[:summary]
      })
    end
  end
end
