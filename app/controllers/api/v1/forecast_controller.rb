class Api::V1::ForecastController < ApplicationController
  def show
    render json: ForecastSerializer.new(Forecast.new(location))
  end

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
