require 'rails_helper'

RSpec.describe PhotoService do
  it 'exists' do
    service = PhotoService.new({})

    expect(service).to be_a PhotoService
  end

  describe 'instance methods' do
    describe 'get_photo' do
      it "returns information for a photo from the location" do
        location = {
          lat: 39.7392358,
          lng: -104.990251
        }

        service = PhotoService.new(location)

        result = service.get_photo

        expect(result).to have_key :id
        expect(result).to have_key :owner
        expect(result).to have_key :secret
        expect(result).to have_key :server
        expect(result).to have_key :farm
        expect(result).to have_key :title
      end
    end
  end
end
