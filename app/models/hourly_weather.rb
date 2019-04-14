class HourlyWeather
  attr_reader :hour,
              :temperature,
              :weather

  def initialize(weather_info)
    @hour = weather_info[:hour]
    @temperature = weather_info[:temperature]
    @weather = weather_info[:weather]
  end

  def self.from_request(request)
    request[:hourly][:data].map do |request_info|
      new({
        hour: Time.at(request_info[:time]).hour,
        temperature: request_info[:temperature],
        weather: request_info[:summary]
      })
    end
  end
end
