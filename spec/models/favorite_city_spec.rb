require 'rails_helper'

RSpec.describe FavoriteCity, type: :model do
  it 'exists' do
    user = create(:user)
    city = user.cities.create(name: "Denver, CO",
                              latitude: 39.7392358,
                              longitude: -104.990251)

    forecast_json = File.read("./spec/fixtures/weather_request.json")
    forecast = JSON.parse(forecast_json, symbolize_names: true)

    favorite_city = FavoriteCity.new(city, forecast)

    expect(favorite_city).to be_a FavoriteCity
  end

  it 'has_attributes' do
    user = create(:user)
    city = user.cities.create(name: "Denver, CO",
                              latitude: 39.7392358,
                              longitude: -104.990251)

    forecast_json = File.read("./spec/fixtures/weather_request.json")
    forecast = JSON.parse(forecast_json, symbolize_names: true)


    favorite_city = FavoriteCity.new(city, forecast)

    expect(favorite_city.city).to eq(city)
    expect(favorite_city.id).to eq(city.id)
    expect(favorite_city.current_temperature).to_not eq(nil)
    expect(favorite_city.perceived_temperature).to_not eq(nil)
    expect(favorite_city.max_temperature).to_not eq(nil)
    expect(favorite_city.min_temperature).to_not eq(nil)
    expect(favorite_city.current_weather).to_not eq(nil)
    expect(favorite_city.humidity).to_not eq(nil)
    expect(favorite_city.visibility).to_not eq(nil)
    expect(favorite_city.uv_index).to_not eq(nil)
    expect(favorite_city.current_description).to_not eq(nil)
    expect(favorite_city.current_description).to_not eq(nil)
  end
end
