class Api::V1::BackgroundsController < ApplicationController
  def show
    render json: BackgroundsSerializer.new(BackgroundFacade.new(location))
  end
end
