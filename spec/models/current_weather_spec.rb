require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'exists' do
    current_forecast = CurrentWeather.new({})

    expect(current_forecast).to be_a CurrentWeather
  end

  it 'has_attributes' do
    forecast_info = {
      current_temperature: 65,
      perceived_temperature: 62,
      max_temperature: 68,
      min_temperature: 57,
      current_weather: "Partly Cloudy",
      humidity: 35.07,
      visibility: 11.5,
      uv_index: 2,
      current_description: "Partly cloudy until evening",
      future_description: "Clear skies through night"
    }
    current_forecast = CurrentWeather.new(forecast_info)

    forecast_info.each do |key, value|
      expect(current_forecast.send(key)).to eq(value)
    end
  end

  describe 'class methods' do
    describe 'from_request' do
      it 'parses a response and creates a current weather object' do
        request = File.open('./spec/fixtures/weather_request.json').read
        parsed_request = JSON.parse(request, symbolize_names: true)
        current_weather = CurrentWeather.from_request(parsed_request)

        expect(current_weather).to be_a CurrentWeather
        expect(current_weather.current_temperature).to eq(45.35)
        expect(current_weather.perceived_temperature).to eq(44.41)
        expect(current_weather.max_temperature).to eq(67.31)
        expect(current_weather.min_temperature).to eq(40.67)
        expect(current_weather.current_weather).to eq("Mostly Cloudy")
        expect(current_weather.humidity).to eq(0.4)
        expect(current_weather.visibility).to eq(9.78)
        expect(current_weather.uv_index).to eq(3)
        expect(current_weather.current_description).to eq("Partly Cloudy")
        expect(current_weather.future_description).to eq("Mostly Cloudy")
      end
    end
  end
end
