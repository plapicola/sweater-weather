class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      user_key = {api_key: SecureRandom.hex}
      user.update(user_key)
      render json: user_key, status: :created
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
