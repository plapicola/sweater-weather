require 'rails_helper'

RSpec.describe 'antipode api' do
  describe 'as a visitor' do
    it 'Returns the current weather at the antipode for a provided city' do
      get '/api/v1/antipode?loc=hongkong'

      antipode = JSON.parse(response.body, symbolize_keys: true)[:data][0]

      expect(antipode).to be_a Hash
      expect(antipose).to have_key :id
      expect(antipode).to have_key :attrbiutes
      expect(antipode).to have_key :search_location
      expect(antipode[:search_location]).to eq("Hong Kong")
      expect(antipode[:attributes]).to have_key :location_name
      expect(antipode[:attributes]).to have_key :forecast
      expect(antipode[:attributes][:forecast]).to have_key :summary
      expect(antipode[:attributes][:forecast]).to have_key :current_temperature
    end
  end
end
