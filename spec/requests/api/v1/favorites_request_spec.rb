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

      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:success]).to eq("Favorite saved successfully")

      favorite = Favorite.last
      expect(favorite.user).to eq(@user)
      expect(favorite.country).to eq(@favorite_params[:country])
      expect(favorite.recipe_link).to eq(@favorite_params[:recipe_link])
      expect(favorite.recipe_title).to eq(@favorite_params[:recipe_title])
    end
  end

  it "can show all a user's favorites" do
    # can be sent as a query param for Endpoint 6 (reqs list)
    get "/api/v1/favorites", params: { api_key: @user.api_key }

  end
end