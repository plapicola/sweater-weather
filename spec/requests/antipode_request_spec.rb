require 'rails_helper'

RSpec.describe 'antipode api' do
  describe 'as a visitor' do
    it 'Returns the current weather at the antipode for a provided city' do
      get '/api/v1/antipode?location=hongkong'

      antipode = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(antipode).to be_a Hash
      expect(antipode).to have_key :id
      expect(antipode).to have_key :attributes
      expect(antipode[:meta]).to have_key :search_location
      expect(antipode[:meta][:search_location]).to eq("Hong Kong")
      expect(antipode[:attributes]).to have_key :location_name
      expect(antipode[:attributes]).to have_key :forecast
      expect(antipode[:attributes][:forecast]).to have_key :summary
      expect(antipode[:attributes][:forecast]).to have_key :current_temperature
    end
  end
end
