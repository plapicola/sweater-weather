require 'rails_helper'

RSpec.describe 'Backgrounds API' do
  context 'as a visitor' do
    it 'I can request a background image for a location' do
      get '/api/v1/backgrounds?location=denver,co'

      image = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(image).to be_a Hash
      expect(image).to have_key :attributes
      expect(image[:attributes]).to have_key :url
    end
  end
end
