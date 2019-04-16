class FavoriteCity < SimpleDelegator
  attr_reader :city
  
  def initialize(city, weather)
    @city = city
    super(CurrentWeather.from_request(weather))
  end

  def id
    @city.id
  end
end
