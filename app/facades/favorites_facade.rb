class FavoritesFacade < BaseFacade
  def initialize(user)
    @user = user
  end

  def id
    @user.id
  end

  def favorites_hash
    @user.cities.map do |city|
      city_hash = {}
      city_hash[:location] = city.name
      weather = CurrentWeather.from_request(request_weather(city.coordinates))
      city_hash[:current_weather] = CurrentWeatherSerializer.new(weather)
      city_hash
    end
  end
end
