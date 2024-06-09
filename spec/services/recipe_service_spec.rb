require 'rails_helper'

RSpec.describe RecipeService do

  it "exists" do
    service = RecipeService.new

    expect(service).to be_an_instance_of RecipeService
  end

  it "#conn" do
    service = RecipeService.new
    connection = service.conn

    expect(connection).to be_an_instance_of Faraday::Connection
    expect(connection.url_prefix.to_s).to eq("https://api.edamam.com/")
  end

  it "#get_url" do
    # Stub the Faraday connection to return a mock response
    allow_any_instance_of(Faraday::Connection).to receive(:get)
    .with('test')
    .and_return(double(body: '{"message": "sldkjslfls"}'))

    service = RecipeService.new
    response = service.get_url('test')

    expect(response).to eq({ message: 'sldkjslfls' })
  end
end