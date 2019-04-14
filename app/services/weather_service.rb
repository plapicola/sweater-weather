class WeatherService
  def initialize(location_args)
    @latitude = location_args[:lat]
    @longitude = location_args[:long]
  end

  def get_forecast
    parse(request_forecast)
  end

  private

  def request_forecast
    conn.get("forecast/#{ENV['DARKSKY_KEY']}/#{@latitude},#{@longitude}")
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.darksky.net/")
  end
end
