require 'rails_helper'

RSpec.describe FavoriteFacade, type: :facade do
  it 'exists' do
    facade = FavoriteFacade.new(nil)

    expect(facade).to be_a FavoriteFacade
  end

  describe 'instance methods' do
    describe 'favorites_hash' do
      it 'returns a hash of information about the favorite' do
        user = create(:user)
        city = user.cities.create(name: "Denver, CO", latitude: 39.7392358, longitude: -104.990251)

        facade = FavoriteFacade.new(city)

        favorites_hash = facade.favorites_hash

        expect(favorites_hash).to have_key :location
        expect(favorites_hash).to have_key :current_weather
        expect(favorites_hash[:location]).to eq("Denver, CO")
        expect(favorites_hash[:current_weather]).to be_a CurrentWeatherSerializer
      end
    end
  end
end
