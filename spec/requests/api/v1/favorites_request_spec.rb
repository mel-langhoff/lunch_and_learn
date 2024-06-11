require 'rails_helper'

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

  describe "/api/v1/favorites" do
    it "can create a favorite" do
      post "/api/v1/favorites"
    end
  end
end