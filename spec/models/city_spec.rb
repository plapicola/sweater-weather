require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'validations' do
    it {should validate_uniqueness_of :name}
    it {should validate_presence_of :name}
    it {should validate_presence_of :latitude}
    it {should validate_presence_of :longitude}
    it {should validate_numericality_of(:latitude)
          .is_greater_than_or_equal_to(-180)
          .is_less_than_or_equal_to(180)
        }
    it {should validate_numericality_of(:longitude)
          .is_greater_than_or_equal_to(-180)
          .is_less_than_or_equal_to(180)
        }
  end

  describe 'relationships' do
    it {should have_many :favorites}
    it {should have_many(:users).through(:favorites)}
  end

  describe 'instance methods' do
    describe '.coordinates' do
      it 'returns a hash of coordinates formatted for other services' do
        denver = City.create(name: "Denver, CO", latitude: 39.7392358, longitude: -104.990251)

        expected = {
          lat: 39.7392358,
          lng: -104.990251
        }

        expect(denver.coordinates).to eq(expected)
      end
    end
  end
end
