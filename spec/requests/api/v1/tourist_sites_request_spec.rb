require 'rails_helper'

RSpec.describe RecipeService do

  it "exists" do
    service = RecipeService.new

    expect(service).to be_an_instance_of RecipeService
  end
end