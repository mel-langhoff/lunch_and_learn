require 'rails_helper'

RSpec.describe "Recipes Api" do
  before :each do
    host! 'localhost:3000'
  end
  
  describe "/api/v1/recipes" do
    it "returns recipes when country parameter is present" do
      VCR.use_cassette("recipe_search") do
        country = "thailand"
        get "/api/v1/recipes?country=#{country}"
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response).to be_a Hash

        recipe = json_response[:data].first[:recipe]

        expect(recipe[:id]).to be_nil
        expect(recipe[:type]).to eq("recipe")

        attributes = recipe[:recipe]
        expect(attributes[:label]).to be_a(String)
        expect(attributes[:url]).to be_a(String)
        expect(attributes[:image]).to be_a(String)
        expect(attributes[:country]).to eq("Thailand")
      end
    end
  end
end