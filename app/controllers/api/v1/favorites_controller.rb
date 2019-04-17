class Api::V1::FavoritesController < ApplicationController
  before_action :validate_user!
  include LocationHelper

  def index
    render json: FavoritesSerializer.new(FavoritesFacade.new(@user))
  end

  def create
    @user.cities << find_location(location[:city], location[:state])
  end

  def destroy
    favorite = @user.favorites.find_by(city: find_location(location[:city], location[:state]))
    favorite.destroy
    render json: FavoritesSerializer.new(FavoriteFacade.new(favorite.city))
  end

  private

  def validate_user!
    @user = User.find_by_api_key(params[:api_key])
    head :unauthorized unless @user
  end
end
