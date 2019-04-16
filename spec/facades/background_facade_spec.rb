require 'rails_helper'

RSpec.describe BackgroundFacade, type: :facade do
  it 'exists' do
    background = BackgroundFacade.new({
      city: 'denver',
      state: 'co'
    })

    expect(background).to be_a BackgroundFacade
  end

  it 'has_attributes' do
    background = BackgroundFacade.new({
      city: 'denver',
      state: 'co'
    })

    expect(background.url).to eq("https://farm8.staticflickr.com/7885/47468856882_4782113425.jpg")
  end
end
