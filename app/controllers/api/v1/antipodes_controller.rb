class Api::V1::AntipodesController < ApplicationController
  def show
    render json: AntipodeSerializer.new(AntipodeFacade.new(location))
  end
end
