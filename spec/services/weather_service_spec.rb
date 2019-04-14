require 'rails_helper'

RSpec.describe WeatherService, type: :service do
  before :each do
    @coordinates = {
      lat: 39.7392358,
      lng: -104.990251
    }

    @service = WeatherService.new(@coordinates)
  end
  it 'exists' do
    expect(@service).to be_a WeatherService
  end

  describe 'instance methods' do
    describe 'get_forecast' do
      it 'requests the forecast for the services coordinates' do
        results = @service.get_forecast

        expect(results).to be_a Hash
        expect(results).to have_key :currently
        expect(results).to have_key :hourly
        expect(results).to have_key :daily

        current_results = results[:currently]

        expect(current_results).to have_key :time
        expect(current_results).to have_key :precipIntensity
        expect(current_results).to have_key :precipProbability
        expect(current_results).to have_key :temperature
        expect(current_results).to have_key :apparentTemperature
        expect(current_results).to have_key :humidity
        expect(current_results).to have_key :uvIndex
        expect(current_results).to have_key :visibility
        expect(current_results).to have_key :ozone

        hourly_results = results[:hourly]

        expect(hourly_results).to be_a Hash
        expect(hourly_results).to have_key :data
        expect(hourly_results[:data]).to be_a Array
        expect(hourly_results[:data][0]).to have_key :time
        expect(hourly_results[:data][0]).to have_key :precipProbability
        expect(hourly_results[:data][0]).to have_key :temperature
        expect(hourly_results[:data][0]).to have_key :apparentTemperature
        expect(hourly_results[:data][0]).to have_key :humidity
        expect(hourly_results[:data][0]).to have_key :uvIndex
        expect(hourly_results[:data][0]).to have_key :visibility
        expect(hourly_results[:data][0]).to have_key :ozone

        daily_results = results[:daily]

        expect(daily_results).to be_a Hash
        expect(daily_results).to have_key :data
        expect(daily_results[:data]).to be_a Array
        expect(daily_results[:data][0]).to have_key :time
        expect(daily_results[:data][0]).to have_key :precipProbability
        expect(daily_results[:data][0]).to have_key :humidity
        expect(daily_results[:data][0]).to have_key :uvIndex
        expect(daily_results[:data][0]).to have_key :visibility
        expect(daily_results[:data][0]).to have_key :ozone
        expect(daily_results[:data][0]).to have_key :temperatureHigh
        expect(daily_results[:data][0]).to have_key :temperatureLow

      end
    end
  end
end
