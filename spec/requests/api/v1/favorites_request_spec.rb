require 'rails_helper'

RSpec.describe "Sessions Api" do
  before :each do
    host! 'localhost:3000'

    @user = User.create!(    
      email: "asdfghjkl@jaja.com",
      name: "Blahblah2",
      password: "test",
      password_confirmation: "test",
      api_key: SecureRandom.hex(16)
    )

    @favorite_params = {
      api_key: @user.api_key,
      country: "spain",
      recipe_link: "www.blah.com",
      recipe_title: "Blah"
    }
  end

  describe "/api/v1/favorites" do
    it "can create a favorite" do
      # params is used to pass parameters to the request body, not to the URL
      post "/api/v1/favorites", params: @favorite_params.to_json, headers: { 'Content-Type': 'application/json' }
# require 'pry'; binding.pry
      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:data][:type]).to eq("favorite")
      expect(json_response[:data][:attributes][:country]).to eq(@favorite_params[:country])
      expect(json_response[:data][:attributes][:recipe_link]).to eq(@favorite_params[:recipe_link])
      expect(json_response[:data][:attributes][:recipe_title]).to eq(@favorite_params[:recipe_title])

      favorite = Favorite.last
      expect(favorite.user).to eq(@user)
      expect(favorite.country).to eq(@favorite_params[:country])
      expect(favorite.recipe_link).to eq(@favorite_params[:recipe_link])
      expect(favorite.recipe_title).to eq(@favorite_params[:recipe_title])
    end
  end
end