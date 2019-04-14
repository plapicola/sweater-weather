require 'rails_helper'

RSpec.describe HourlyWeather do
  it 'exists' do
    current_forecast = HourlyWeather.new({})

    expect(current_forecast).to be_a HourlyWeather
  end

  it 'has_attributes' do
    forecast_info = {
      temperature: 65,
      perceived_temperature: 62,
      weather: "Partly Cloudy",
      humidity: 35.07,
      visibility: 11.5,
      uv_index: 2,
    }
    current_forecast = HourlyWeather.new(forecast_info)

    forecast_info.each do |key, value|
      expect(current_forecast.send(key)).to eq(value)
    end
  end

  describe 'class methods' do
    describe 'from_request' do
      it 'parses a response and creates a current weather object' do
        request = File.open('./spec/fixtures/weather_request.json').read
        parsed_request = JSON.parse(request, symbolize_names: true)
        hourly_weather = HourlyWeather.from_request(parsed_request)

        expect(hourly_weather).to be_a Array
        expect(hourly_Weather[0]).to be_a HourlyWeather
        expect(hourly_weather[0].hour).to eq(11)
        expect(hourly_weather[0].weather).to eq("Mostly Cloudy")
        expect(hourly_weather[0].temperature).to eq(40.04)
      end
    end
  end
end
