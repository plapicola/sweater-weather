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
      },
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }

      expect(response).to be_successful
      expect(Favorites.count).to eq(1)
    end

    it 'I receive a 401 if I provide bad credentials' do
      post "/api/v1/favorites", params: {
        location: "Denver, CO",
        api_key: ""
      },
      headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
      }

      expect(response.status).to eq(401)
      expect(Favorites.count).to eq(0)
    end

    it 'I can retreive my favorites' do
      @user.cities.create(name: "Denver, CO")
      get '/api/v1/favorites', params: {
        api_key: @user.api_key
      },
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }

      favorites = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(favorites).to be_a Array
      expect(favorites[0]).to have_key :id
      expect(favorites[0]).to have_key :attributes
      expect(favorites[0][:attributes]).to have_key :name
      expect(favorites[0][:attributes][:name]).to eq("Denver, CO")
      expect(favorites[0][:attributes]).to have_key :current_weather
      expect(favorites[0][:attributes][:current_weather]).to have_key [:data]
    end

    it 'I receive a 401 if I request favorites with bad credentials' do
      @user.cities.create(name: "Denver, CO")
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
      @user.cities.create(name: "Denver, CO")
      delete '/api/v1/favorites', params: {
        location: "Denver, CO",
        api_key: @user.api_key
      },
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }

      favorites = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(favorites).to be_a Array
      expect(favorites[0]).to have_key :id
      expect(favorites[0]).to have_key :attributes
      expect(favorites[0][:attributes]).to have_key :name
      expect(favorites[0][:attributes][:name]).to eq("Denver, CO")
      expect(favorites[0][:attributes]).to have_key :current_weather
      expect(favorites[0][:attributes][:current_weather]).to have_key [:data]
      expect(Favorites.count).to eq(0)
    end

    it 'I receive a 401 if deleting with bad credentials' do
      @user.cities.create(name: "Denver, CO")
      delete '/api/v1/favorites', params: {
        location: "Denver, CO",
        api_key: @user.api_key
      },
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json"
      }

      expect(response.status).to eq(401)
      expect(Favorites.count).to eq(1)
    end
  end
end
