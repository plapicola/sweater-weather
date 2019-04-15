require 'rails_helper'

RSpec.describe Photo do
  it 'exists' do
    photo = Photo.new({})

    expect(photo).to be_a Photo
  end

  it 'has_attributes' do
    photo_info = {
      id: '47468856882',
      owner: "67020828@N04",
      secret: "4782113425",
      server: "7885",
      farm: "8",
      title: "Denver Colorado – Skyline"
    }
    photo = Photo.new(photo_info)

    photo_info.each do |key, value|
      expect(photo.send(key)).to eq(value)
    end
  end

  describe 'instance methods' do
    describe '.url' do
      it 'returns a url for accessing the image' do
        photo_info = {
          id: '47468856882',
          owner: "67020828@N04",
          secret: "4782113425",
          server: "7885",
          farm: "8",
          title: "Denver Colorado – Skyline"
        }
        photo = Photo.new(photo_info)

        expected = "https://farm8.staticflickr.com/7885/47468856882_4782113425.jpg"

        expect(photo.url).to eq(expected)
      end
    end
  end
end
