class FavoritesFacade
  def initialize(user)
    @user = user
  end

  def favorites
    @user.cities.map do |city|
      FavoriteCity.new(city)
    end
  end
end
