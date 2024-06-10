require 'rails_helper'

RSpec.describe PexelService do

  it "exists" do
    service = PexelService.new

    expect(service).to be_an_instance_of PexelService
  end

  it "#get_images" do
    VCR.use_cassette("get_pexel_imgs") do
      country = "Laos"
      search = PexelService.get_images(country)

      expect(search).to be_an Array
      # require 'pry'; binding.pry
      expect(search.size).to be <= 10

      search.each do |photo|
        expect(photo).to be_a Hash

        expect(photo).to have_key(:alt_tag)
        expect(photo[:alt_tag]).to be_a(String)

        expect(photo).to have_key(:url)
        expect(photo[:url]).to be_a(String)
      end
    end
  end
end