require 'rails_helper'

RSpec.describe RecipeService do

  it "exists" do
    service = RecipeService.new

    expect(service).to be_an_instance_of RecipeService
  end

  it "#get_recipes_by_country" do
    VCR.use_cassette("recipes_by_country") do
      country = "Spain"
      search = RecipeService.get_recipes_by_country(country)

      expect(search).to be_an Array
      #require 'pry'; binding.pry

      recipe_data = search.first
      expect(recipe_data).to have_key :label
      expect(recipe_data).to have_key :url
      expect(recipe_data).to have_key :image
      expect(recipe_data[:label]).to be_a String
    end
  end
end