require 'rails_helper'

RSpec.describe FavoritesFacade, type: :facade do
  it 'exists' do
    facade = FavoritesFacade.new(nil)

    expect(facade).to be_a FavoritesFacade
  end

  describe 'instance methods' do
    describe 'favorites' do
      it 'returns a collection of FavoriteCity objects' do
        user = create(:user)
        user.cities.create(name: "Denver, CO",
                           latitude: 39.7392358,
                           longitude: -104.990251)

        facade = FavoritesFacade.new(user)

        expect(facade.favorites).to be_a Array
        expect(facade.favorites[0]).to be_a FavoriteCity
        expect(facade.favorites[0].id).to eq(user.cities.first.id)
      end
    end
  end
end
