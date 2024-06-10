require 'rails_helper'

RSpec.describe "TouristSites Api" do
  before :each do
    host! 'localhost:3000'
  end
  describe "/api/v1/tourist_sites" do
    it "returns a list of tourist sites when country param is present" do
      VCR.use_cassette("tourist_site_search") do
        country = "France"
        get "/api/v1/tourist_sites?country=#{country}"
        
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response).to have_key(:data)
        expect(json_response[:data]).to be_an(Array)
        expect(json_response[:data].length).to eq(10)

        site = json_response[:data].first
        expect(site[:id]).to be_nil
        expect(site[:type]).to eq("tourist_site")

        expect(site[:attributes][:name]).to be_a(String)
        expect(site[:attributes][:address]).to be_a(String)
        expect(site[:attributes][:place_id]).to be_a(String)
      end
    end
  end
end