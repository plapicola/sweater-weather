class FavoritesSerializer
  # include FastJsonapi::ObjectSerializer
  #
  # attribute :current_weather do |obj|
  #   obj.favorites.map do |favorite|
  #     CurrentWeatherSerializer.new(favorite)
  #   end

  def initialize(facade)
    @facade = facade
  end

  def to_json(arg_hash)
    @facade.favorites_hash.to_json
  end
end
