class FavoritesFacade < BaseFacade
  def initialize(user)
    @user = user
  end

  def id
    @user.id
  end

  def favorites_hash
    # Refactor me to not need extra hash
    @user.cities.map do |city|
      weather = CurrentWeather.from_request(request_weather(city.coordinates))
      {
        location: city.name,
        current_weather: CurrentWeatherSerializer.new(weather)
      }
    end
  end
end
