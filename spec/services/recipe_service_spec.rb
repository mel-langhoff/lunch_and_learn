require 'rails_helper'

RSpec.describe RecipeService do

  it "exists" do
    service = RecipeService.new

    expect(service).to be_an_instance_of RecipeService
  end

  it "#get_recipes_by_country" do
    VCR.use_cassette("recipes_by_country") do
      country = "Spain"
      search = RecipeService.new.get_recipes_by_country(country)

      expect(search[:hits]).to be_an Array

      recipe_data = search[:hits].first[:recipe]

      expect(recipe_data).to have_key :label
      expect(recipe_data).to have_key :url
      expect(recipe_data).to have_key :image
      expect(recipe_data[:label]).to be_a String
    end
  end
end