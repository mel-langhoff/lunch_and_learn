require 'rails_helper'

RSpec.describe "Recipes Api" do
  describe "/api/v1/recipes" do
    it "returns recipes when country parameter is present" do
      VCR.use_cassette("recipe_search") do
        # file = File.read("spec/fixtures/thailand.json")
        # stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=3040a7e4&app_key=#{Rails.application.credentials.edamam[:api_key]}&q=thailand&type=public").
        #   with(
        #     headers: {
        #   'Accept'=>'*/*',
        #   'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        #   'User-Agent'=>'Faraday v2.9.0'
        #     }).
        #   to_return(status: 200, body: file, headers: {})
    
        # get "/api/v1/recipes?country=thailand", headers: {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}
    
        # json_response = JSON.parse(response.body, symbolize_names: true)
    
        # expect(response).to be_successful
        # expect(json_response[:data].first[:from]).to eq(nil)
        # expect(json_response[:data].first[:to]).to eq(nil)
        # expect(json_response[:data].first[:count]).to eq(nil)
        # expect(json_response[:data].first[:hits]).to eq(nil)
        # expect(json_response[:data].first).to_not eq(nil)
        # expect(json_response[:data].first[:id]).to eq(nil)
        # expect(json_response[:data].first[:type]).to eq("recipe")
        # expect(json_response[:data].first[:attributes]).to be_a(Hash)
        # expect(json_response[:data].first[:attributes][:title]).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
        # expect(json_response[:data].first[:attributes][:url]).to eq("https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html")
        # expect(json_response[:data].first[:attributes][:country]).to eq("thailand")
        # expect(json_response[:data].first[:attributes][:image]).to be_a(String)
      

        country = "thailand"
        get "/api/v1/recipes?country=#{country}"
# require 'pry'; binding.pry
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body, symbolize_names: true)

        # expect(json).to be_an Array

        recipe = json[:data].first

        expect(recipe[:id]).to be_nil
        expect(recipe[:type]).to eq("recipe")

        attributes = recipe[:attributes]
        expect(attributes[:label]).to be_a(String)
        expect(attributes[:url]).to be_a(String)
        expect(attributes[:image]).to be_a(String)
        expect(attributes[:country]).to eq("Thailand")
      end
    end
  end
end