class PhotoService
  def initialize(location_info)
    @latitude = location_info[:lat]
    @longitude = location_info[:lng]
  end

  def get_photo
    parse(request_photograph)
  end

  private

  def parse(response)
    Hash.from_xml(response.body)["rsp"]["photos"]["photo"][0].symbolize_keys!
  end

  def request_photograph
    conn.get do |req|
      req.params[:method] = "flickr.photos.search"
      req.params[:tags] = "skyline"
      req.params[:lat] = @latitude
      req.params[:lon] = @longitude
      req.params[:radius] = 32 # 32 km radius is max
    end
  end

  def conn
    Faraday.new(url: 'https://api.flickr.com/services/rest/') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.params[:api_key] = ENV['FLICKR_KEY']
      faraday.params[:safe_search] = 1
      faraday.params[:content_type] = 1
    end
  end
end
