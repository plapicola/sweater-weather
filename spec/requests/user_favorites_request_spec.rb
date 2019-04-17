require 'rails_helper'

RSpec.describe 'Favorites API' do
  context 'as a user' do
    before :each do
      @user = create(:user)
    end

    it 'I can create new favorite cities' do
      VCR.use_cassette('requests/new_favorite') do
        post "/api/v1/favorites", params: {
          location: "Denver, CO",
          api_key: @user.api_key
        }.to_json,
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }
      end

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
      VCR.use_cassette('requests/favorites_index') do
        get '/api/v1/favorites', params: {
          api_key: @user.api_key
        },
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }
      end

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
        VCR.use_cassette('requests/delete_favorite') do
        delete '/api/v1/favorites', params: {
          location: "Denver, CO",
          api_key: @user.api_key
        }.to_json,
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }
      end

      favorites = JSON.parse(response.body, symbolize_names: true)

      expect(favorites).to be_a Hash
      expect(favorites).to have_key :location
      expect(favorites).to have_key :current_weather
      expect(favorites[:location]).to eq("denver, co")
      expect(favorites[:current_weather]).to have_key :data
      expect(favorites[:current_weather][:data]).to have_key :attributes
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

    it 'I can add, view, and remove a favorite' do
      VCR.use_cassette('requests/favorite_workflow') do
        # Add favorites
        post "/api/v1/favorites", params: {
          location: "denver, co",
          api_key: @user.api_key
        }.to_json,
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }
        post "/api/v1/favorites", params: {
          location: "seattle, wa",
          api_key: @user.api_key
        }.to_json,
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }

        # Get favorites
        get '/api/v1/favorites', params: {
          api_key: @user.api_key
        },
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }

        # Favorites should have Denver and be 2 in length
        favorites = JSON.parse(response.body, symbolize_names: true)

        expect(favorites).to be_a Array
        expect(favorites.length).to eq(2)
        expect(favorites[0][:location]).to eq("denver, co")

        # Delete a favorite
        delete '/api/v1/favorites', params: {
          location: "denver, co",
          api_key: @user.api_key
        }.to_json,
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }

        # Get favorites to validate removal
        get '/api/v1/favorites', params: {
          api_key: @user.api_key
        },
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json"
        }

        # Expect favorite to be of length 1 and not include denver
        favorites = JSON.parse(response.body, symbolize_names: true)

        expect(favorites).to be_a Array
        expect(favorites.length).to eq(1)
        expect(favorites[0][:location]).to eq("seattle, wa")
      end
    end
  end
end
