require 'rails_helper'

RSpec.describe "Recipes Api" do
  before :each do
    host! 'localhost:3000'
  end

  describe "/api/v1/learning_resources" do
    it "returns learning resources when country param is present" do
      VCR.use_cassette("learning_resources_search") do
        country = "laos"
        get "/api/v1/learning_resources?country=#{country}"

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body, symbolize_names: true)

        expect(json_response).to be_a Hash

        data = json_response[:data]
        expect(data).to be_a Hash
        expect(data[:id]).to be_nil
        expect(data[:type]).to eq("learning_resource")
        
        attributes = json_response[:data][:attributes]
        expect(attributes[:country]).to eq("laos")
        expect(attributes[:video]).to be_a Hash
        expect(attributes[:video][:title]).to be_a(String)
        expect(attributes[:video][:youtube_video_id]).to be_a(String)

        expect(attributes[:images]).to be_an Array
        expect(attributes[:images].size).to be <= 10
      end
    end
  end
end