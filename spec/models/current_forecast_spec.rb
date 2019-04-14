require 'rails_helper'

RSpec.describe CurrentForecast do
  it 'exists' do
    current_forecast = CurrentForecast.new({})

    expect(current_forecast).to be_a CurrentForecast
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
    current_forecast = CurrentForecast.new(forecast_info)

    forecast_info.each do |key, value|
      expect(current_forecast.send(key)).to eq(value)
    end
  end
end
