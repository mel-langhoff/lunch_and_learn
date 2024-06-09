class Api::V1::RecipesController < ApplicationController

  def index
    country = params[:country]
    recipes = RecipeService.get_recipes_by_country(country)

    if recipes.any?
      render json: RecipeSerializer.new
    else
      render json: { data: [] }
    end
  end
end