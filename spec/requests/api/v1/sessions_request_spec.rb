require 'rails_helper'

RSpec.describe "Sessions Api" do
  before :each do
    host! 'localhost:3000'

    @user_params =
    {
      email: "blah@jaja.com",
      name: "Blahblah",
      password: "test",
      password_confirmation: "test"
    }
  end

  describe "/api/v1/sessions" do
    it "can create a session" do
      post "/api/v1/sessions"

      expect(response).to have_http_status(:ok)

    end
  end
end