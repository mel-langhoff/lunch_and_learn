class Api::V1::UsersController < ApplicationController

  def create
    if params[:password] == params[:password_confirmation]
      user = User.new(user_params)

      if user.save
        render json: UserSerializer.new(user), status: :created
      else
        render json: { errors: user.errors.full_messages.to_sentence }, status: :unprocessable_entity
      end
    else
      render json: { error: "Passwords do not match." }, status: :unprocessable_entity
    end
  end

  private
  
  def user_params
    params.permit(:email, 
                  :name, 
                  :password, 
                  :password_confirmation)
  end
end