class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private
  
  def user_params
    params.permit(:email, 
                  :name, 
                  # :password_digest, 
                  :password, 
                  :password_confirmation)
  end
end