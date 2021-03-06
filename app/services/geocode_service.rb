class GeocodeService
  def get_coordinates(city, state = nil)
    parse(request_coordinates(city, state))[:geometry][:location]
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)[:results][0]
  end

  def request_coordinates(city, state)
    conn.get do |req|
      req.params[:address] = "#{city},+#{state}"
    end
  end

  def conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api/geocode/json') do |f|
      f.params[:key] = ENV['GOOGLE_GEOCODE_KEY']
      f.adapter Faraday.default_adapter
    end
  end
end
