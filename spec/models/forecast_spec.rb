require 'rails_helper'

RSpec.describe Forecast do
  it 'exists' do
    forecast = Forecast.new(city: 'denver', state: 'co')

    expect(forecast).to be_a Forecast
  end

  it 'has attributes' do
    forecast = Forecast.new({city: "denver", state: "co"})

    expect(forecast.id).to eq("denver, co")
    expect(forecast.city).to eq("denver")
    expect(forecast.state).to eq("co")
    expect(forecast.current_weather).to be_a CurrentWeather
    expect(forecast.hourly_forecasts).to be_a Array
    expect(forecast.daily_forecasts).to be_a Array
  end
end
