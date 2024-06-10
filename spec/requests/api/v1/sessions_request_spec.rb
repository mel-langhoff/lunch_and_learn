RSpec.describe "Sessions Api" do
  before :each do
    host! 'localhost:3000'

    @user = User.create!(    
      email: "blah2@jaja.com",
      name: "Blahblah2",
      password: "test",
      password_confirmation: "test"
    )
  end

  describe "/api/v1/sessions" do
    it "can create a session" do
      post "/api/v1/sessions", params: { email: @user.email, password: "test" }

      expect(response).to have_http_status(:ok)

      # Use strings, not symbols, to access JSON keys in response bodies, as JSON parsing converts keys to strings by default.
      json_response = JSON.parse(response.body)
      expect(json_response["data"]["type"]).to eq("user")
      expect(json_response["data"]["attributes"]["name"]).to eq(@user.name)
      expect(json_response["data"]["attributes"]["email"]).to eq(@user.email)
      expect(json_response["data"]["attributes"]["api_key"]).to eq(@user.api_key)
    end
  end
end
