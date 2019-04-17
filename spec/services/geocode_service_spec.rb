require 'rails_helper'

RSpec.describe GeocodeService, type: :service do
  it 'exists' do
    service = GeocodeService.new

    expect(service).to be_a GeocodeService
  end

  describe 'instance methods' do
    describe '.get_coordinates' do
      it 'can translate a city and state in to coordinates' do
        service = GeocodeService.new

        expected = {
          lat: 39.7392358,
          lng: -104.990251
        }

        VCR.use_cassette('services/geocode') do
          expect(service.get_coordinates("denver", "co")).to eq(expected)
        end
      end
    end
  end
end
