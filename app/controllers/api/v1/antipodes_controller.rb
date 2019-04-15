class Api::V1::AntipodesController < ApplicationController
  def show
    render json: AntipodeSerializer.new(Antipode.new(location))
  end
end
