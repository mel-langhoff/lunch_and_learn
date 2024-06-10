# require 'rails_helper'

# RSpec.describe PexelService do

#   it "exists" do
#     service = PexelService.new

#     expect(service).to be_an_instance_of PexelService
#   end

#   it "#get_images" do
#     VCR.use_cassette("get_pexel_imgs") do
#       country = "Laos"
#       search = PexelService.new.get_images(country)

#       expect(search).to be_a(Hash)

#       expect(search[:results]).to be_an(Array)
#       expect(search[:results].size).to be <= 10

#       first_image = search[:results].first
#       expect(first_image).to have_key(:alt_description)
#       expect(first_image[:alt_description]).to be_a(String)

#       expect(first_image).to have_key(:urls)
#       expect(first_image[:urls]).to have_key(:full)
#       expect(first_image[:urls][:full]).to be_a(String)
#     end
#   end
# end