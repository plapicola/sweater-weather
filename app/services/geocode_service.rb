class GeocodeService
  def initialize(city, state)
    @city = city&.gsub(" ", "+")
    @state = state
  end

  def get_coordinates
    parse(request_coordinates)[:results][0][:geometry][:location]
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def request_coordinates
    conn.get do |req|
      req.params[:address] = "#{@city},+#{@state}"
    end
  end

  def conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api/geocode/json') do |f|
      f.params[:key] = ENV['GOOGLE_GEOCODE_KEY']
      f.adapter Faraday.default_adapter
    end
  end
end
