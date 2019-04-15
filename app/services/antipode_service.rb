class AntipodeService
  def get_antipode(coordinates)
    result = parse(request_antipode(coordinates[:lat], coordinates[:lng]))
    {
      lat: result[:attributes][:lat],
      lng: result[:attributes][:long]
    }
  end

  private

  def request_antipode(latitude, longitude)
    conn.get("antipodes") do |req|
      req.params[:lat] = latitude
      req.params[:long] = longitude
    end
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def conn
    Faraday.new(url: "http://amypode.herokuapp.com/api/v1/") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers[:api_key] = ENV['AMYPODE_KEY']
    end
  end
end
