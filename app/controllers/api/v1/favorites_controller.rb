class Api::V1::FavoritesController < ApplicationController

  def create
    user = User.find_by(api_key: params[:api_key])

    if user
      favorite = user.favorites.new(favorite_params)

      if favorite.save
        render json: FavoriteSerializer.new(favorite), status: :created
      else
        render json: { errors: favorite.errors.full_messages.to_sentence }, status: :unprocessable_entity
      end
    else
      render json: { error: "Incorrect API key." }, status: :unauthorized
    end
  end

  private

  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end
end