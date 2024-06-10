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

      expect(search).to be_an Array
      expect(search.first).to be_a Hash

      expect(search.first).to have_key(:title)
      expect(search.first[:title]).to be_a(String)

      expect(search.first).to have_key(:youtube_video_id)
      expect(search.first[:youtube_video_id]).to be_a(String)
    end
  end
end