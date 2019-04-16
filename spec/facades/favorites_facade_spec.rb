require 'rails_helper'

RSpec.describe FavoritesFacade, type: :facade do
  it 'exists' do
    facade = FavoritesFacade.new(nil)

    expect(facade).to be_a FavoritesFacade
  end

  describe 'instance methods' do
    describe 'favorites_hash' do
      it 'returns a collection of hashes including location and current weather' do
        user = create(:user)
        user.cities.create(name: "Denver, CO",
                           latitude: 39.7392358,
                           longitude: -104.990251)

        facade = FavoritesFacade.new(user)

        expect(facade.favorites_hash).to be_a Array
        expect(facade.favorites_hash[0]).to have_key :location
        expect(facade.favorites_hash[0]).to have_key :current_weather
        expect(facade.favorites_hash[0][:current_weather]).to be_a CurrentWeatherSerializer
      end
    end
  end
end
