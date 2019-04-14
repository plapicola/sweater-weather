require 'rails_helper'

RSpec.describe DailyWeather do
  it 'exists' do
    daily_weather = DailyWeather.new({})

    expect(daily_weather).to be_a DailyWeather
  end

  it 'has attrbutes' do
    daily_info = {
      day: "Sunday",
      weather: "Mostly Cloudy",
      percipitation_chance: 0.10,
      max_temperature: 63.0,
      min_temperature: 23.0
    }

    daily_weather = DailyWeather.new(daily_info)

    daily_info.each do |key, value|
      expect(daily_weather.send(key)).to eq(value)
    end
  end

  describe 'class methods' do
    describe 'from_request' do
      it 'creates an array of DailYWeather objects from a service request' do
        request = File.open('./spec/fixtures/weather_request.json').read
        parsed_request = JSON.parse(request, symbolize_names: true)
        daily_weather = DailyWeather.from_request(parsed_request)

        expect(daily_weather).to be_a Array
        expect(daily_weather[0].day).to eq("Sunday")
        expect(daily_weather[0].weather).to eq("Mostly cloudy throughout the day")
        expect(daily_weather[0].percipitation_chance).to eq(0.05)
        expect(daily_weather[0].max_temperature).to eq(67.31)
        expect(daily_weather[0].min_temperature).to eq(40.67)
      end
    end
  end
end
