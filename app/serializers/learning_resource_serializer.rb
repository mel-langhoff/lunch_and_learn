class LearningResourceSerializer
  include JSONAPI::Serializer

  set_id { nil }
  set_type :learning_resource

  attributes :country, :video, :images

  # attribute :video do |object|
  #   {
  #     title: object.video[:title],
  #     youtube_video_id: object.video[:youtube_video_id]
  #   }
  # end

  # attribute :images do |object|
  #   object.images.map do |image|
  #     {
  #       alt_tag: image[:alt_tag],
  #       url: image[:url]
  #     }
  #   end
  # end
end