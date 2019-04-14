class Api::V1::BackgroundsController < ApplicationController
  def show
    render json: BackgroundsSerializer.new(Background.new(location))
  end
end
