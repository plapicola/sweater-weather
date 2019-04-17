require 'rails_helper'

RSpec.describe 'Forecast API', type: :request do
  context 'as a visitor' do
    before :each do
      Rails.cache.clear
    end

    it "I can request the current forecast for a city, state" do
      get '/api/v1/forecast?location=denver,co'

      weather_info = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(weather_info).to have_key :id
      expect(weather_info).to have_key :attributes
      expect(weather_info[:attributes]).to have_key :name
      expect(weather_info[:attributes][:name]).to eq 'denver, co'
      expect(weather_info[:attributes]).to have_key :current_weather
      expect(weather_info[:attributes]).to have_key :hourly_forecasts
      expect(weather_info[:attributes]).to have_key :daily_forecasts

      current_forecast = weather_info[:attributes][:current_weather][:data]

      expect(current_forecast[:attributes]).to have_key :current_temperature
      expect(current_forecast[:attributes]).to have_key :perceived_temperature
      expect(current_forecast[:attributes]).to have_key :max_temperature
      expect(current_forecast[:attributes]).to have_key :min_temperature
      expect(current_forecast[:attributes]).to have_key :current_weather
      expect(current_forecast[:attributes]).to have_key :humidity
      expect(current_forecast[:attributes]).to have_key :visibility
      expect(current_forecast[:attributes]).to have_key :uv_index
      expect(current_forecast[:attributes]).to have_key :current_description
      expect(current_forecast[:attributes]).to have_key :future_description

      hourly_forecast = weather_info[:attributes][:hourly_forecasts][:data]

      expect(hourly_forecast).to be_a Array
      expect(hourly_forecast[0][:attributes]).to have_key :hour
      expect(hourly_forecast[0][:attributes]).to have_key :temperature
      expect(hourly_forecast[0][:attributes]).to have_key :weather

      daily_forecast = weather_info[:attributes][:daily_forecasts][:data]

      expect(daily_forecast).to be_a Array
      expect(daily_forecast[0][:attributes]).to have_key :day
      expect(daily_forecast[0][:attributes]).to have_key :weather
      expect(daily_forecast[0][:attributes]).to have_key :percipitation_chance
      expect(daily_forecast[0][:attributes]).to have_key :max_temperature
      expect(daily_forecast[0][:attributes]).to have_key :min_temperature
    end

    it 'subsequent requests are cached' do
      expect(WeatherService).to receive(:new).once.and_call_original

      get '/api/v1/forecast?location=denver,co'
      get '/api/v1/forecast?location=denver,co'
    end
  end
end
