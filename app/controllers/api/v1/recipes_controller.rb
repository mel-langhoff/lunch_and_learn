class Api::V1::RecipesController < ApplicationController

  def index
    country = params[:country]
    data = RecipeService.get_recipes_by_country(country)
    recipes = data[:hits]
# require 'pry'; binding.pry
    if recipes.any?
      render json: RecipeSerializer.new(recipes)
    else
      render json: { data: [] }
    end
  end
end