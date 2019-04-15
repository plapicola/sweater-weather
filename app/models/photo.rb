class Photo
  attr_reader :id,
              :owner,
              :secret,
              :server,
              :farm,
              :title

  def initialize(photo_info)
    @id = photo_info[:id]
    @owner = photo_info[:owner]
    @secret = photo_info[:secret]
    @server = photo_info[:server]
    @farm = photo_info[:farm]
    @title = photo_info[:title]
  end

  def url
    "https://farm#{@farm}.staticflickr.com/#{@server}/#{@id}_#{@secret}.jpg"
  end
end
