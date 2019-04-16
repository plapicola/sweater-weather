class FavoritesFacade < BaseFacade
  def initialize(user)
    @user = user
  end

  def favorites_hash
    @user.cities.map do |city|
      weather = CurrentWeather.from_request(request_weather(city.coordinates))
      {
        location: city.name,
        current_weather: CurrentWeatherSerializer.new(weather)
      }
    end
  end
end
