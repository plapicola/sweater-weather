class FavoriteFacade < BaseFacade
  def initialize(city)
    @city = city
  end

  def favorites_hash
    weather = CurrentWeather.from_request(request_weather(@city.coordinates))
    {
      location: @city.name,
      current_weather: CurrentWeatherSerializer.new(weather)
    }
  end
end
