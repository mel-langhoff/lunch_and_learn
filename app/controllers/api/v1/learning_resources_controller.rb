class Api::V1::LearningResourcesController < ApplicationController

  def index
    country = params[:country]
    video = YoutubeService.get_video(country)
    images = PexelService.get_images(country)

    if video.present? && images.any?
      learning_resource = LearningResource.new(country, video, images)
      render json: LearningResourceSerializer.new(learning_resource)
    else
      render json: empty_resource(country), status: :not_found
    end
  end

  private

  def empty_resource(country)
    {
      data: {
        id: nil,
        type: "learning_resource",
        attributes: {
          country: country,
          video: {},
          images: []
        }
      }
    }
  end
end