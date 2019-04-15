require 'rails_helper'

RSpec.describe AntipodeService, type: :service do
  it 'exists' do
    service = AntipodeService.new

    expect(service).to be_a AntipodeService
  end

  describe 'instance_methods' do
    describe '.get_antipode' do
      it 'returns the antipode coordinates for a provided location' do
        service = AntipodeService.new

        search_location = {
          lat: 22.561968,
          lng: 114.4294999
        }

        antipode = service.get_antipode(search_location)

        expect(antipode).to have_key :lat
        expect(antipode).to have_key :long
        expect(antipode[:lat]).to eq(-22.561968)
        expect(antipode[:long]).to eq(-65.5705001)
      end
    end
  end

end
