class Api::V1::FavoritesController < ApplicationController

  # serializer needed in index action to format response data properly according to reqs
  def index
    user = User.find_by(api_key: params[:api_key])
    
    if user
      favorites = user.favorites.order(created_at: :desc)
      render json: favorites.map { |favorite| FavoriteSerializer.new(favorite) }, status: :ok
    else
      render json: { error: "Invalid API key" }, status: :unauthorized
    end
  end

  # no serializer needed in create action b/c rendering a simple success/error message directly as json
  def create
    user = User.find_by(api_key: params[:api_key])
    favorite = user.favorites.new(favorite_params)

    if favorite.save
      render json: { success: "Favorite saved successfully" }, status: :created
    else
      render json: { errors: favorite.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  private

  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end
end