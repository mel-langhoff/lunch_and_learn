require 'rails_helper'

RSpec.describe PexelService do

  it "exists" do
    service = PexelService.new

    expect(service).to be_an_instance_of PexelService
  end

  it "#get_images" do
    VCR.use_cassette("get_pexel_imgs") do
      country = "Laos"
      search = PexelService.new.get_images(country)

      expect(search).to be_a(Hash)

      expect(search[:photos]).to be_an(Array)
      expect(search[:photos].size).to be <= 10

      image = search[:photos].first
      expect(image).to have_key(:alt)
      expect(image[:alt]).to be_a(String)

      expect(image).to have_key(:url)
      expect(image[:url]).to be_a(String)
    end
  end
end