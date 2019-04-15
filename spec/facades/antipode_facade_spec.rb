require 'rails_helper'

RSpec.describe AntipodeFacade, type: :facade do
  it 'exists' do
    antipode = AntipodeFacade.new({city: "hongkong"})

    expect(antipode).to be_a AntipodeFacade
  end

  it 'has_attributes' do
    location_info = {
      city: "hongkong"
    }
    antipode = AntipodeFacade.new(location_info)

    expect(antipode.search_location).to eq("Hong Kong")
    expect(antipode.location_name).to eq("Jujuy")
    expect(antipode.forecast).to be_a CurrentWeather
  end
end
