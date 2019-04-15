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

    it 'I receive a 400 when I attempt to create an account with bad credentials' do
      body = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "paSSw0rD"
      }
      post '/api/v1/users', params: body


      expect(response.status).to eq(400)
      expect(User.count).to eq(0)
    end
  end
end
