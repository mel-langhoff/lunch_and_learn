class Api::V1::LearningResourcesController < ApplicationController

  def index
    country = params[:country]
    videos = YoutubeService.get_video(country)
    images = PexelService.get_images(country)

    if videos.any? && images.any?
      render json: LearningResourcesSerializer.new(country, videos, images)
    end

  end
end