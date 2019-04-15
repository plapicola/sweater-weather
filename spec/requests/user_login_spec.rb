require 'rails_helper'

RSpec.describe 'Sessions API' do
  describe 'as a visitor' do
    it 'I can submit a request to log in and be given my token' do
      user = create(:user, email: "whatever@example.com",
                           password: "password",
                           api_key: "jgn983hy48thw9begh98h4539h4")

      post '/api/v1/sessions', params: {
        email: "whatever@example.com",
        password: 'password'
      }

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:api_key]).to eq("jgn983hy48thw9begh98h4539h4")
      expect(response.status).to eq(200)
    end

    it 'I receive a 401 when I provide bad credentials' do
      user = create(:user, email: "whatever@example.com",
                           password: "password",
                           api_key: "jgn983hy48thw9begh98h4539h4")

      post '/api/v1/sessions', params: {
        email: "whatever@example.com",
        password: 'notmypassword'
      }

      expect(response.status).to eq(401)
    end
  end
end
