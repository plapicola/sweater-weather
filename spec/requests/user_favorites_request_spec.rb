require 'rails_helper'

RSpec.describe 'Favorites API' do
  context 'as a user' do
    before :each do
      @user = create(:user)
    end

    it 'I can create new favorite cities' do
      post "/api/v1/favorites", params: {
        location: "Denver, CO",
        api_key: @user.api_key
      }.to_json,
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }

      expect(response).to be_successful
      expect(Favorite.count).to eq(1)
    end

    it 'I receive a 401 if I provide bad credentials' do
      post "/api/v1/favorites", params: {
        location: "Denver, CO",
        api_key: ""
      }.to_json,
      headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
      }

      expect(response.status).to eq(401)
      expect(Favorite.count).to eq(0)
    end

    it 'I can retreive my favorites' do
      @user.cities.create(name: "Denver, CO", latitude: 39.7392358, longitude: -104.990251)
      get '/api/v1/favorites', params: {
        api_key: @user.api_key
      },
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }

      favorites = JSON.parse(response.body, symbolize_names: true)

      expect(favorites).to be_a Array
      expect(favorites[0]).to have_key :location
      expect(favorites[0]).to have_key :current_weather
      expect(favorites[0][:location]).to eq("Denver, CO")
      expect(favorites[0][:current_weather]).to have_key :data
      expect(favorites[0][:current_weather][:data]).to have_key :attributes
    end

    it 'I receive a 401 if I request favorites with bad credentials' do
      @user.cities.create(name: "Denver, CO", latitude: 39.7392358, longitude: -104.990251)
      get '/api/v1/favorites', params: {
        api_key: ""
      },
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }

      expect(response.status).to eq(401)
    end

    it 'I can remove cities from my favorites' do
      @user.cities.create(name: "denver, co", latitude: 39.7392358, longitude: -104.990251)
      delete '/api/v1/favorites', params: {
        location: "Denver, CO",
        api_key: @user.api_key
      }.to_json,
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }

      favorites = JSON.parse(response.body, symbolize_names: true)

      binding.pry

      expect(favorites).to be_a Array
      expect(favorites[0]).to have_key :location
      expect(favorites[0]).to have_key :current_weather
      expect(favorites[0][:location]).to eq("Denver, CO")
      expect(favorites[0][:current_weather]).to have_key :data
      expect(favorites[0][:current_weather][:data]).to have_key :attributes
      expect(Favorite.count).to eq(0)
    end

    it 'I receive a 401 if deleting with bad credentials' do
      @user.cities.create(name: "Denver, CO", latitude: 39.7392358, longitude: -104.990251)
      delete '/api/v1/favorites', params: {
        location: "Denver, CO",
        api_key: ""
      }.to_json,
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }

      expect(response.status).to eq(401)
      expect(Favorite.count).to eq(1)
    end
  end
end
