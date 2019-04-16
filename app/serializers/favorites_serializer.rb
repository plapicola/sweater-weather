class FavoritesSerializer
  include FastJsonapi::ObjectSerializer

  attribute :current_weather do |obj|
    obj.favorites.map do |favorite|
      CurrentWeatherSerializer.new(favorite)
    end
  end
end
