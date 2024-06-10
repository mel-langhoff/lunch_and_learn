class Api::V1::RecipesController < ApplicationController

  def index
    country = params[:country]
    recipes = fetch_recipes(country)
# require 'pry'; binding.pry
    if recipes.any?
      render json: RecipeSerializer.new(recipes[:hits]).serializable_hash
    else
      render json: { data: [] }
    end
  end
  
  private

  def fetch_recipes(country)
    service = RecipeService.new
    service.get_recipes_by_country(country)
  end
end