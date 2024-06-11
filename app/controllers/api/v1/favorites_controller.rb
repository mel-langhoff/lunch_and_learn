class Api::V1::FavoritesController < ApplicationController

  def create
    user = User.find_by(api_key: params[:api_key])

    if user
      favorite = Favorite.create
    else
      # error for incorrect API key
    end
  end
end