require 'rails_helper'

RSpec.describe ForecastFacade, type: :facade do
  it 'exists' do
    forecast = VCR.use_cassette('facades/forecast') do
      ForecastFacade.new(city: 'denver', state: 'co')
    end

    expect(forecast).to be_a ForecastFacade
  end

  it 'has attributes' do
    forecast = VCR.use_cassette('facades/forecast') do
      ForecastFacade.new({city: "denver", state: "co"})
    end

    expect(forecast.id).to eq("denver, co")
    expect(forecast.city).to eq("denver")
    expect(forecast.state).to eq("co")
    expect(forecast.current_weather).to be_a CurrentWeather
    expect(forecast.hourly_forecasts).to be_a Array
    expect(forecast.daily_forecasts).to be_a Array
  end
end
