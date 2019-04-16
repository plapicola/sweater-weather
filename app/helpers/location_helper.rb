module LocationHelper

  def find_location(city, state = nil)
    City.find_by_name("#{city}, #{state}".strip) || create_new_location(city, state)
  end

  def create_new_location(city, state)
    coordinates = GeocodeService.new.get_coordinates(city, state)
    City.create({
      name: "#{city}, #{state}".strip,
      latitude: coordinates[:lat],
      longitude: coordinates[:lng]
    })
  end
end
