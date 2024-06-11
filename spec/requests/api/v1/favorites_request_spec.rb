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
    user = User.create!(    
      email: "lksdsljfdsdfsf@jaja.com",
      name: "Rando User",
      password: "test",
      password_confirmation: "test",
      api_key: SecureRandom.hex(16)
    )
    fave1 = user.favorites.create!(
      country: "Spain",
      recipe_link: "www.qwertyuiop.com",
      recipe_title: "Paella"
    )

    fave2 = user.favorites.create!(
      country: "Canada",
      recipe_link: "www.asdfghjkl.com",
      recipe_title: "Poutine"
    )

    # can be sent as a query param for Endpoint 6 (reqs list)
    get "/api/v1/favorites", params: { api_key: user.api_key }

    json_response = JSON.parse(response.body, symbolize_names: true)
    favorites = json_response.map do |favorite|
      favorite[:data][:attributes]
    end

    expect(favorites).to be_an(Array)
    expect(favorites.size).to eq(2)

    # favorites = [{:country=>"Canada", :recipe_title=>"Poutine", :recipe_link=>"www.asdfghjkl.com", :created_at=>"2024-06-11T02:33:41.001Z"}, {:country=>"Spain", :recipe_title=>"Paella", :recipe_link=>"www.qwertyuiop.com", :created_at=>"2024-06-11T02:33:40.998Z"}]
    # favorites = [fave2, fave1]
    # fave2
    expect(favorites[0][:recipe_title]).to eq("Poutine")
    expect(favorites[0][:recipe_link]).to eq("www.asdfghjkl.com")
    expect(favorites[0][:country]).to eq("Canada")

    # fave1
    expect(favorites[1][:recipe_title]).to eq("Paella")
    expect(favorites[1][:recipe_link]).to eq("www.qwertyuiop.com")
    expect(favorites[1][:country]).to eq("Spain")
  end
end