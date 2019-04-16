class ApplicationController < ActionController::API

  private

  def location
    {
      city: location_params.first.downcase.strip,
      state: location_params.last.downcase.strip
    }
  end

  def location_params
    params[:location].split(",")
  end
end
