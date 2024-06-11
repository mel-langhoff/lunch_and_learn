require 'rails_helper'

RSpec.describe "Users Api" do
  before :each do
    host! 'localhost:3000'

    @user_params =
    {
      email: "blah@jaja.com",
      name: "Blah",
      password: "blah",
      password_confirmation: "blah"
    }
  end

  describe "/api/v1/users" do
    it "can create a user" do
      # params is used to pass parameters to the request body, not to the URL
      # When you're sending a JSON payload in the body of a request, you need to specify the content type as JSON ('Content-Type': 'application/json') in the headers. Additionally, you need to convert your parameters to JSON format using .to_json before sending them in the request body.
      # By including .to_json on your parameters and setting the content type header to 'application/json', you ensure that the parameters are sent in the request body as a JSON payload
      post "/api/v1/users", params: @user_params.to_json, headers: { 'Content-Type': 'application/json' } 

      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:data][:type]).to eq("user")
      expect(json_response[:data][:attributes][:name]).to eq(@user_params[:name])
      expect(json_response[:data][:attributes][:email]).to eq(@user_params[:email])
      expect(json_response[:data][:attributes][:api_key]).to be_present

      user = User.last
      expect(user.name).to eq(@user_params[:name])
      expect(user.email).to eq(@user_params[:email])
    end
  end
end