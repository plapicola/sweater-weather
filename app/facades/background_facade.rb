class BackgroundFacade
  def initialize(location_info)
    @city = location_info[:city]
    @state = location_info[:state]
    @photo = find_photograph
  end

  def id
    "#{@city}, #{@state}"
  end

  def url
    @photo.url
  end

  private

  def find_photograph
    Photo.new(request_photograph(request_location))
  end

  def request_location
    @coordinates ||= GeocodeService.new.get_coordinates(@city, @state)
  end

  def request_photograph(location)
    @photo_info ||= PhotoService.new(@coordinates).get_photo
  end

end
