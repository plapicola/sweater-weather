require 'rails_helper'

RSpec.descrive Forecast do
  it 'exists' do
    forecast = Forecast.new({})

    expect(forecast).to be_a Forecast
  end

  it 'has attributes' do
    forecast = Forecast.new([["denver"], ["co"]])

    expect(forecast.id).to eq("Denver, CO")
    expect(forecast.city).to eq("Denver")
    expect(forecast.state).to eq("CO")
    expect(forecast.current_weather).to be_a CurrentForecast
    expect(forecast.hourly_forecasts).to be_a Array
    expect(forecast.daily_forecast).to be_a Array
  end
end
