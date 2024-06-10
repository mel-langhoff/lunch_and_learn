class LearningResource
  attr_reader :country, :video, :images

  def initialize(country, video, images)
    @country = country
    @video = video
    @images = images
    #   images.map do |image|
    #   {
    #     alt_tag: image[:alt_tag],
    #     url: image[:url]
    #   }
    # end
  end
end