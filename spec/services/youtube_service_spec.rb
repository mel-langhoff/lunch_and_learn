require 'rails_helper'

RSpec.describe YoutubeService do

  it "exists" do
    service = YoutubeService.new

    expect(service).to be_an_instance_of YoutubeService
  end

  it "#get_video" do
    VCR.use_cassette("get_yt_vids") do
      country = "Laos"
      search = YoutubeService.get_video(country)

      expect(search).to be_a(Hash)

      expect(search[:items]).to be_an(Array)
      expect(search[:items].first[:snippet][:title]).to be_a(String)
      expect(search[:items].first[:id][:videoId]).to be_a(String)
    end
  end
end