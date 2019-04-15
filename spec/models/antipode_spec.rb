require 'rails_helper'

RSpec.describe Antipode do
  it 'exists' do
    antipode = Antipode.new({city: "hongkong"})

    expect(antipode).to be_a Antipode
  end

  it 'has_attributes' do
    location_info = {
      city: "hongkong"
    }
    antipode = Antipode.new(location_info)

    expect(antipode.search_location).to eq("Hong Kong")
    expect(antipode.location_name).to eq("Jujuy")
    expect(antipode.forecast).to be_a CurrentWeather
  end
end
