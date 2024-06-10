require 'rails_helper'

RSpec.describe GeoapifyService do

  it "exists" do
    service = GeoapifyService.new

    expect(service).to be_an_instance_of GeoapifyService
  end

  it "#get_coordinates" do
    VCR.use_cassette("get_coordinates") do
      country = "Spain"
      search = GeoapifyService.get_coordinates(country)

      expect(search).to be_a(Hash)
      expect(search).to have_key(:lat)
      expect(search).to have_key(:lon)
    end
  end

  it "#get_tourist_sites" do
    VCR.use_cassette("get_tourist_sites") do
      lat = 48.8566
      lon = 2.3522
      search = GeoapifyService.get_tourist_sites(lat, lon)

      expect(search).to be_an(Array)
      expect(search.size).to be <= 10

      site = search.first
      expect(site).to have_key(:name)
      expect(site).to have_key(:address)
      expect(site).to have_key(:place_id)
    end
  end
end