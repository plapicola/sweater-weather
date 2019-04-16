class Api::V1::FavoritesController < ApplicationController
  include LocationHelper

  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      user.cities << find_location(location)
    else
      head :unauthorized
    end
  end
end
