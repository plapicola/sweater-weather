class ApplicationController < ActionController::API

  private

  def location
    {
      city: location_params.first.downcase,
      state: location_params.last.downcase
    }
  end

  def location_params
    params[:location].split(",")
  end
end
