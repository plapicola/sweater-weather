require 'rails_helper'

RSpec.describe 'Backgrounds API' do
  context 'as a visitor' do
    before :each do
      Rails.cache.clear
    end
    it 'I can request a background image for a location' do
      VCR.use_cassette('requests/backgrounds') do
        get '/api/v1/backgrounds?location=denver,co'
      end

      image = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(image).to be_a Hash
      expect(image).to have_key :attributes
      expect(image[:attributes]).to have_key :url
    end

    it 'subsequent requests for a location are cached' do
      expect(PhotoService).to receive(:new).once.and_call_original

      VCR.use_cassette('requests/backgrounds') do
        get '/api/v1/backgrounds?location=denver,co'
        get '/api/v1/backgrounds?location=denver,co'
      end
    end
  end
end
