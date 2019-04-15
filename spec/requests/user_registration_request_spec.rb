require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  context 'as a visitor' do
    it 'I can submit credentials to create an account' do
      body = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }
      post '/api/v1/users', params: body

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)
      expect(results).to have_key :api_key
      expect(User.count).to eq(1)
    end
  end
end
