reqire 'rails_helper'

RSpec.describe WeatherService, type: :service do
  it 'exists' do
    service = WeatherService.new(coordinates)

    expect(service).to be_a WeatherService
  end

  describe 'instance methods' do
    describe 'get_forecast' do
      it 'requests the forecast for the services coordinates' do
        
      end
    end
  end
end
