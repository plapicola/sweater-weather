class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user.authenticate(params[:password])
      render json: {api_key: user.api_key}, status: :ok
    else
      head :unauthorized
    end
  end
end
